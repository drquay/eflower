import { ChangeDetectionStrategy, ChangeDetectorRef, Component, ElementRef, Inject, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { UserService } from '@core/authentication/user.service';
import { SettingsService } from '@core/bootstrap/settings.service';
import { environment } from '@env/environment';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { AccountResDto } from 'app/dto/account-res.dto';
import { OrderAttachmentReqDto } from 'app/dto/order-attachment-req.dto';
import { OrderAttachmentResDto } from 'app/dto/order-attachment-res.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { AttachmentService } from 'app/services/attachment.service';
import { ImageService } from 'app/services/image.service';
import { OrderAttachmentService } from 'app/services/order-attachment.service';
import { OrderService } from 'app/services/order.service';
import PhotoViewer from 'photoviewer';
import { Subscription } from 'rxjs';


@Component({
  selector: 'page-image-edit',
  templateUrl: './image-edit.component.html',
  styleUrls: ['./image-edit.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    UserService,
    OrderService,
    OrderAttachmentService,
  ],
})
export class ImageEditComponent implements OnInit {
  translateSubscription!: Subscription;
  apiUrl: string;
  orderResDto?: OrderResDto;
  attachments: OrderAttachmentResDto[] = [];
  fileNames: string[] = [];

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialog: MatDialog,
    public dialogRef: MatDialogRef<ImageEditComponent>,
    private settings: SettingsService,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,

    private userService: UserService,
    private attachmentService: AttachmentService,
    private imageService: ImageService,
    private orderService: OrderService,
  ) {
    this.apiUrl = environment.apiUrl + '/files';
    
    this.orderResDto = data;

  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
    });

    this.attachments = this.orderResDto?.attachments ?? [];
    this.fileNames = this.attachments.map(item => item.name??'');
  }


  @ViewChild('chooseFiles') chooseFiles?: ElementRef;
  onChooseFiles(imgFile: any) {
    if (imgFile.target.files && imgFile.target.files[0]) {
      Array.from(imgFile.target.files).forEach((file: any) => {
        let fileName = file.name;
        let fileType = file.type;
        if (!this.fileNames.find((item) => item === fileName)) {
          // Upload file.
          this.imageService.upload(file).subscribe(
            (link) => {
              let orderAttachmentReqDto = new OrderAttachmentReqDto();
              orderAttachmentReqDto.url = link;
              orderAttachmentReqDto.name = fileName;
              orderAttachmentReqDto.fileExtension = fileType;
              // Save image.
              this.attachmentService.create(orderAttachmentReqDto).subscribe(
                (imgId: string) => {
                  this.orderService.addImagesToOrder(this.orderResDto?.id ?? '', [imgId]).subscribe(
                    (response) => {
                      let orderAttatchResDto = new OrderAttachmentResDto();
                      orderAttatchResDto.id = imgId;
                      orderAttatchResDto.url = link;
                      orderAttatchResDto.name = fileName;
                      orderAttatchResDto.fileExtension = fileType;
                      orderAttatchResDto.uploadedBy = new AccountResDto();
                      orderAttatchResDto.uploadedBy.fullName = this.userService.get().name;
                      this.attachments.push(orderAttatchResDto);
                      this.fileNames = [...this.fileNames, fileName]
                      this.cdr.detectChanges();
                    },
                    (error) => {
                      this.fileNames = this.fileNames.filter(item => item !== fileName);
                      this.cdr.detectChanges();
                    }
                  );
                },
                (error) => {
                  this.fileNames = this.fileNames.filter(item => item !== fileName);
                  this.cdr.detectChanges();
                },
                () => {
                  // this.fileNames = this.fileNames.filter(item => item !== fileName);
                  this.cdr.detectChanges();
                }
              )
            }
          )
        }
      });
    } else {
    }
  }

  // Preview image.
  previewImage(index: number) {
    const options: PhotoViewer.Options = { index };
    let images: any[] = [];
    this.attachments.forEach((item, index) => {
      images.push({
        title: (index + 1) + ' - ' + item.name + ' (' + item.uploadedBy?.fullName + ')',
        src: item.url,
      });
    })
    const viewer = new PhotoViewer(images, options);
  }

  // Confirm delete image.
  deleteImage(attachment: OrderAttachmentResDto) {
    const dialogRef = this.dialog.open(ConfirmDialogComponent);
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.attachmentService.delete(attachment.id ?? '').subscribe(
          (response: any) => {
            this.attachments = this.attachments.filter(item => item.id !== attachment.id);
            this.fileNames = this.fileNames.filter(item => item !== attachment.name);
            this.cdr.detectChanges();
          },
          (error: any) => {

          }
        );
      }
    });
  }

  onClose(): void {
    this.dialogRef.close();
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

}
