import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, LOCALE_ID, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core/bootstrap/settings.service';
import { TranslateService } from '@ngx-translate/core';
import { OrderAttachmentResDto } from 'app/dto/order-attachment-res.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import PhotoViewer from 'photoviewer';
import { Subscription } from 'rxjs';


@Component({
  selector: 'page-image-viewer',
  templateUrl: './image-viewer.component.html',
  styleUrls: ['./image-viewer.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
  ],
})
export class ImageViewerComponent implements OnInit {
  translateSubscription!: Subscription;
  orderResDto?: OrderResDto;
  attachments: OrderAttachmentResDto[] = [];
  fileNames: string[] = [];
  selectedFiles: any[] = [];
  fileName: string = '';
  images: any[] = [];
  currentImage: any = '';

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialogRef: MatDialogRef<ImageViewerComponent>,
    private settings: SettingsService,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,
  ) {

    this.orderResDto = data;

  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
    });

    this.attachments = this.orderResDto?.attachments?? [];
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

  onClose(): void {
    this.dialogRef.close();
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

}
