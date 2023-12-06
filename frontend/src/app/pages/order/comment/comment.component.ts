import { DatePipe, DecimalPipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, ElementRef, Inject, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core';
import { UserService } from '@core/authentication/user.service';
import { environment } from '@env/environment';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { PaymentTypeEnum } from '@shared/constants/payment-type.enum';
import { CommonUtil } from '@shared/utils/common-util';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AttachmentReqDto } from 'app/dto/attachment-req.dto';
import { AttachmentResDto } from 'app/dto/attachment-res.dto';
import { OrderCommentReq } from 'app/dto/order-comment-req.dto';
import { OrderCommentRes } from 'app/dto/order-comment-res.dto';
import { OrderPaymentReq } from 'app/dto/order-payment-req.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { ProductReqDto } from 'app/dto/product-req.dto';
import { ProductResDto } from 'app/dto/product-res.dto';
import { AttachmentService } from 'app/services/attachment.service';
import { ImageService } from 'app/services/image.service';
import { OrderService } from 'app/services/order.service';
import { ProductService } from 'app/services/product.service';
import { Subscription } from 'rx';
import { ImageEditComponent } from '../image/image-edit.component';


@Component({
  selector: 'page-order-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.scss'],
  providers: [
    DatePipe,
    DecimalPipe,

    OrderService,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class OrderCommentComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  apiUrl: string;
  editItem: OrderResDto = new OrderResDto();
  editMode: boolean = false;
  editId?: string;

  attachments: AttachmentResDto[] = [];
  fileNames: string[] = [];
  
  columns: MtxGridColumn[] = [
    {
      header: "Ngày ghi chú",
      field: 'createdOn',
      sortable: true,
      disabled: false,
      minWidth: 200,
    },
    {
      header: "Nội dung",
      field: 'content',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: this.translate.stream('common.operation'),
      field: 'operation',
      minWidth: 120,
      width: '120px',
      pinned: 'right',
      type: 'button',
      buttons: [
        {
          type: 'icon',
          icon: 'edit',
          tooltip: this.translate.stream('common.edit'),
          click: record => this.edit(record),
        },
        {
          type: 'icon',
          icon: 'image',
          tooltip: 'Xem ảnh',
          click: record => this.previewImageBy(record),
          iif: record => record.attachments && record.attachments.length > 0,
        },
      ],
    },
  ];
  list: OrderCommentRes[];
  total = 0;

  multiSelectable = false;
  rowSelectable = false;
  hideRowSelectionCheckbox = false;
  showToolbar = false;
  columnHideable = true;
  columnMovable = true;
  rowHover = false;
  rowStriped = true;
  pageOnFront = false;
  showPaginator = false;
  expandable = false;
  columnResizable = false;

  defaultQuery = {
    page: 0,
    size: 5,
    search: '',
    by: '',
    sortBy: 'createdOn',
    ascDirection: '0',
  };
  query = {...this.defaultQuery};

  get params() {
    const p = Object.assign({}, this.query);
    // p.page += 1;
    return p;
  }

  constructor(
    public _MatPaginatorIntl: MatPaginatorIntl,
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    public dialogRef: MatDialogRef<OrderCommentComponent>,
    private settings: SettingsService,
    private route: ActivatedRoute,
    private decimalPipe: DecimalPipe,
    private cdr: ChangeDetectorRef,
    private datePipe: DatePipe,
    private snackBar: MatSnackBar,
    public dialog: MtxDialog,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,

    private userService: UserService,
    private attachmentService: AttachmentService,
    private orderService: OrderService,
    private imageService: ImageService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;
    this.apiUrl = environment.apiUrl + '/files';
    this.editItem = data;
    this.list = data.comments ?? [];
    // sort
    this.list = this.list.sort((item1, item2) => {
      if (item1.createdOn && item2.createdOn) {
        return item2.createdOn.localeCompare(item1.createdOn); // item2 before item1.
      }
      return -1;
    });

    this.list.forEach((item, index) => {
      item.index1 = index + 1;
      item.createdOn = this.datePipe.transform(item.createdOn, this.settings.getLanguage() === 'vi-VN' ? 'dd/MM/yyyy [HH:mm:ss]' : 'MM/dd/yyyy [HH:mm:ss]') ?? '';
    });

    this.reactiveForm = this.fb.group({
      content: ['', [Validators.required]],
      attachments: [],
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

  ngOnInit() {
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

  // Preview image.
  previewImageBy(record: OrderCommentRes) {
    let index: number = 0;
    const options: PhotoViewer.Options = { index };
    let images: any[] = [];
    record.attachments?.forEach((item, index) => {
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
    let isError = this.reactiveForm.get('content')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }

    let amount = Number.parseInt(this.unformatNumber(this.reactiveForm.get('amount')?.value + ''));
    let imgIds = this.attachments.map(item => item.id ?? '');
    let orderPaymentReq: OrderCommentReq = {
      content: this.reactiveForm.get('content')?.value + '',
      attachmentIds: imgIds,
    }
    var result;
    if (this.editMode) {
      result = this.orderService.updateComment(this.editItem.id?? '', this.editId ?? '', orderPaymentReq);
    } else {
      result = this.orderService.addComment(this.editItem.id?? '', orderPaymentReq);
    }
    result.subscribe(
      (response) => {
        this.dialogRef.close();
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


  // MatPaginator Output
  // pageEvent!: PageEvent;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageChanged(event?: PageEvent) {
    // console.log(event);
    this.query.page = event?.pageIndex ?? 0;
    this.query.size = event?.pageSize ?? 0;
  }

  search() {
    this.query.page = 0;
  }

  reset() {
    this.query = {...this.defaultQuery};
  }

  createNew() {
    this.editMode = false;
    this.editId = '';
    this.reactiveForm.get('content')?.setValue('');
    this.attachments = [];
    this.fileNames = this.attachments.map(item => item.name??'');
  }

  edit(item: OrderCommentRes) {
    this.editMode = true;
    this.editId = item.id ?? '';
    this.reactiveForm.get('content')?.setValue(item.content);
    this.attachments = item.attachments ?? [];
    this.fileNames = this.attachments.map(item => item.name??'');
  }


  // delete(value: ProductReqDto) {
  //   this.dialog.alert(`You have deleted ${value.code}!`);
  // }

  changeSelect(e: any) {
    // console.log(e);
  }

  changeSort(e: any) {
    // console.log(e);
  }

  enableRowExpandable() {
    this.columns[0].showExpand = this.expandable;
  }

  updateCell() {
  }

  updateList() {
  }
}
