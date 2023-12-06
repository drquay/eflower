import { DecimalPipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectorRef } from '@angular/core';
import { ViewChild } from '@angular/core';
import { ElementRef } from '@angular/core';
import { LOCALE_ID } from '@angular/core';
import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core';
import { UserService } from '@core/authentication/user.service';
import { environment } from '@env/environment';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AttachmentReqDto } from 'app/dto/attachment-req.dto';
import { AttachmentResDto } from 'app/dto/attachment-res.dto';
import { ProductReqDto } from 'app/dto/product-req.dto';
import { ProductResDto } from 'app/dto/product-res.dto';
import { AttachmentService } from 'app/services/attachment.service';
import { ImageService } from 'app/services/image.service';
import { ProductService } from 'app/services/product.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'page-product-edit',
  templateUrl: './product-edit.component.html',
  styleUrls: ['./product-edit.component.scss'],
  providers: [
    DecimalPipe,

    UserService,
    AttachmentService,
    ProductService,
  ],
})
export class ProductEditComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  apiUrl: string;
  editItem: ProductResDto = new ProductResDto();
  editMode: boolean = false;

  attachments: AttachmentResDto[] = [];
  fileNames: string[] = [];

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    public dialog: MtxDialog,
    public dialogRef: MatDialogRef<ProductEditComponent>,
    private settings: SettingsService,
    private route: ActivatedRoute,
    private decimalPipe: DecimalPipe,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: ProductResDto,

    private userService: UserService,
    private attachmentService: AttachmentService,
    private imageService: ImageService,
    private productService: ProductService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;
    this.apiUrl = environment.apiUrl + '/files';

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0 && !!this.editItem.id;

    this.reactiveForm = this.fb.group({
      code: [this.editItem.code, [Validators.required]],
      name: [this.editItem.name, [Validators.required]],
      description: [this.editItem.description],
      referenceUrl: [this.editItem.referenceUrl],
      price: [this.formatNumber(this.editItem.price?.toString()), [Validators.required]],
      attachments: [[]],
      fileNames: [[]],
    });

  }

  registerLocale(lang: string) {
    // console.log(this.locale);
    if (lang === 'vi-VN') {
      this.locale = 'vi';
      registerLocaleData(localeVi, 'currentLocale');
    } else {
      this.locale = 'en';
      registerLocaleData(localeEn, 'currentLocale');
    }
  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.dateAdapter.setLocale(res.lang);
    });

    this.attachments = this.editItem.images?? [];
    this.fileNames = this.attachments.map(item => item.name??'');
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

  formatNumber(value?: string): string {
    if (!value) {
      return '';
    }
    return this.decimalPipe.transform(value, '1.0-3', 'currentLocale') ?? '';
  }

  unformatNumber(value?: string): string {
    if (!value) {
      return '';
    }
    const regExp = new RegExp(`[^\\d${this.decimalMarker}-]`, 'g');
    return value.replace(regExp, '');
  }

  onFocusNumber(event: any) {
    event.target.value = this.unformatNumber(event.target.value);
  }

  onBlurNumber(event: any) {
    event.target.value = this.formatNumber(event.target.value);
  }

  onChange(event: any) {
    // event.target.value = this.formatNumber(event.target.value);
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
              let attachmentReqDto = new AttachmentReqDto();
              attachmentReqDto.url = link;
              attachmentReqDto.name = fileName;
              attachmentReqDto.fileExtension = fileType;
              // Save image.
              this.attachmentService.create(attachmentReqDto).subscribe(
                (imgId: string) => {
                  let attachmentResDto = new AttachmentResDto();
                  attachmentResDto.id = imgId;
                  attachmentResDto.url = link;
                  attachmentResDto.name = fileName;
                  // attachmentResDto.fileExtension = fileType;
                  attachmentResDto.uploadedBy = new AccountResDto();
                  attachmentResDto.uploadedBy.fullName = this.userService.get().name;

                  this.attachments.push({ ...attachmentResDto });
                  this.fileNames = [...this.fileNames, fileName]
                  this.cdr.detectChanges();
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
        id: item.id,
        title: (index + 1) + ' - ' + item.name + ' (' + item.uploadedBy?.fullName + ')',
        src: item.url,
      });
    })
    const viewer = new PhotoViewer(images, options);
  }

  // Confirm delete image.
  deleteImage(attachment: AttachmentResDto) {
    const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: null,
    });
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

  getErrorMessage(form: FormGroup) {
    return form.get('email')?.hasError('required')
      ? 'validations.required'
      : form.get('email')?.hasError('email')
      ? 'validations.invalid_email'
      : '';
  }

  isError() : boolean {
    let isError = this.reactiveForm.get('code')?.hasError('required')
    || this.reactiveForm.get('name')?.hasError('required')
    || this.reactiveForm.get('price')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }

    let price = Number.parseInt(this.unformatNumber(this.reactiveForm.controls['price'].value));
    let imgIds = this.attachments.map(item => item.id ?? '');
    let productDto: ProductReqDto = {
      code: this.reactiveForm.controls['code'].value,
      name: this.reactiveForm.controls['name'].value,
      description: this.reactiveForm.controls['description'].value,
      referenceUrl: this.reactiveForm.controls['referenceUrl'].value,
      price: price,
      imgIds: imgIds,
    }
    productDto.images = [...this.attachments];

    // console.log(productDto);

    var result;
    if (this.editMode) {
      result = this.productService.update(this.editItem.id?? '', productDto);
    } else {
      result = this.productService.create(productDto);
    }
    result.subscribe(
      (response) => {
        this.dialogRef.close({...productDto, id: response});
      },
      (error) => {

      },
      () => {

      }
    )
  }

  onClose(): void {
    this.dialogRef.close();
  }
}
