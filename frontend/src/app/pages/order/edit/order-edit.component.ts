import { DatePipe, DecimalPipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, ElementRef, Inject, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { UserService } from '@core/authentication/user.service';
import { SettingsService } from '@core/bootstrap/settings.service';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { OrderSource } from '@shared/constants/order-source.enum';
import { OrderStatusEnum } from '@shared/constants/order-status.enum';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AccountDto } from 'app/dto/account.dto';
import { CustomerDto } from 'app/dto/customer.dto';
import { OrderAttachmentReqDto } from 'app/dto/order-attachment-req.dto';
import { OrderAttachmentResDto } from 'app/dto/order-attachment-res.dto';
import { OrderCreateReqDto } from 'app/dto/order-create-req.dto';
import { OrderPaymentReq } from 'app/dto/order-payment-req.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { OrderStatusDto } from 'app/dto/order-status.dto';
import { OrderUpdateReqDto } from 'app/dto/order-update-req.dto';
import { ProductReqDto } from 'app/dto/product-req.dto';
import { ProductResDto } from 'app/dto/product-res.dto';
import { CustomerEditComponent } from 'app/pages/customer/edit/customer-edit.component';
import { ProductEditComponent } from 'app/pages/product/edit/product-edit.component';
import { AccountService } from 'app/services/account.service';
import { CustomerService } from 'app/services/customer.service';
import { AttachmentService } from 'app/services/attachment.service';
import { OrderService } from 'app/services/order.service';
import { ProductService } from 'app/services/product.service';
import * as moment from 'moment';
import PhotoViewer from 'photoviewer';
import { Observable, Subscription } from 'rxjs';
import { PaymentTypeEnum } from '@shared/constants/payment-type.enum';
import { OrderSourceDto } from 'app/dto/order-source.dto';
import { ImageService } from 'app/services/image.service';
import { environment } from '@env/environment';
import { OrderAttachmentEnum } from '@shared/constants/order-attachment.enum';


@Component({
  selector: 'page-order-edit',
  templateUrl: './order-edit.component.html',
  styleUrls: ['./order-edit.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    UserService,
    OrderService,
    AttachmentService,
    DatePipe,
    DecimalPipe,
  ],
})
export class OrderEditComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  apiUrl: string;
  editItem: OrderResDto = new OrderResDto();
  editMode: boolean = false;
  minPaymentDate: Date = new Date(Date.now() + 0 * 60 * 60 * 1000); // 0 hour.
  lstOrderSourceDto: OrderSourceDto[] = [
    { value: OrderSource.HCM, name: "Hồ chí minh" },
    { value: OrderSource.OTHER, name: "Đơn tỉnh" },
    { value: OrderSource.AGENT, name: "Đối tác" },
  ];
  lstOrderStatusDto: OrderStatusDto[] = [
    { value: OrderStatusEnum.ALL, name: "Tất cả", quantity: 0 },
    { value: OrderStatusEnum.NEW, name: "Đơn mới", quantity: 0 },
    { value: OrderStatusEnum.DOING, name: "Đang làm", quantity: 0 },
    { value: OrderStatusEnum.DONE, name: "Làm xong", quantity: 0 },
    { value: OrderStatusEnum.CUSTOMER_SATISFIED, name: "Khách đồng ý", quantity: 0 },
    { value: OrderStatusEnum.CUSTOMER_REJECTED, name: "Khách từ chối", quantity: 0 },
    { value: OrderStatusEnum.SALE_REJECTED, name: "Hủy đơn", quantity: 0 },
    { value: OrderStatusEnum.SHIPPING, name: "Đang giao", quantity: 0 },
    { value: OrderStatusEnum.SHIPPED_WITH_PAYMENT, name: "Giao có thu tiền", quantity: 0 },
    { value: OrderStatusEnum.SHIPPED_WITH_NONPAYMENT, name: "Giao không thu tiền", quantity: 0 },
    { value: OrderStatusEnum.ERROR, name: "Gặp sự cố", quantity: 0 },
    { value: OrderStatusEnum.FINISHED, name: "Hoàn tất", quantity: 0 },
  ];
  lstAccountDto: AccountDto[] = [];
  lstProductDto: ProductResDto[] = [];
  lstCustomerDto: CustomerDto[] = [];
  attachments: OrderAttachmentResDto[] = [];
  deleteAttachments: OrderAttachmentResDto[] = [];

  public currentDate?: moment.Moment = moment();
  @ViewChild('picker') picker: any;
  public minDate?: moment.Moment = moment();
  public maxDate?: moment.Moment;

  // orderStatus = OrderStatus;
  unsort(a: any, b: any) {
    return 1;
  }

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialog: MtxDialog,
    public dialogRef: MatDialogRef<OrderEditComponent>,
    private settings: SettingsService,
    private datePipe: DatePipe,
    private decimalPipe: DecimalPipe,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,

    private userService: UserService,
    private accountService: AccountService,
    private productService: ProductService,
    private customerService: CustomerService,
    private orderService: OrderService,
    private attachmentService: AttachmentService,
    private imageService: ImageService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;
    this.dateAdapter.setLocale(this.settings.getLanguage());
    this.apiUrl = environment.apiUrl + '/files';

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0;

    let depositAmount: number = 0;
    if (this.editItem.deposit) {
      depositAmount = this.editItem.deposit.amount ?? 0;
    }
    this.reactiveForm = this.fb.group({
      // code: [this.editItem.code, [this.editMode? Validators.required : () => null]],
      code: [{ value: this.editItem.code, disabled: !this.editMode }],
      productId: [this.editItem.product?.id],
      price: [this.formatNumber(this.editItem.price?.toString()), [Validators.required]],
      depositAmount: [{ value: this.formatNumber(depositAmount.toString()), disabled: this.editMode }, [Validators.required]],
      source: [this.editItem.source, [Validators.required]],
      // status: [this.editItem.status, [this.editMode? Validators.required : () => null]],
      status: [{ value: this.editItem.status, disabled: true }],
      deliveryDateTime: [{ value: this.editItem.deliveryDateTime, disabled: false }, [Validators.required]],
      customerMessage: [this.editItem.customerMessage],
      noteForShipper: [this.editItem.noteForShipper, []],
      noteForFlorist: [this.editItem.noteForFlorist, []],
      buyerId: [this.editItem.buyer?.id, [Validators.required]],
      receiverId: [this.editItem.receiver?.id, [Validators.required]],
      supportedSaleId: [this.editItem.supportedSale?.id, [Validators.required]],
      attachments: [[]],
      productName: [''],
      buyerName: ['', [Validators.required]],
      receiverName: ['', [Validators.required]],
      supportedSaleName: ['', [Validators.required]],
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

  // Product auto complete.
  lstProductDtoFiltered?: ProductResDto[];
  productDto?: ProductResDto;
  setProductDto(item: ProductResDto) {
    this.productDto = item;
    if (this.productDto) {
      this.reactiveForm.get('productId')?.setValue(this.productDto.id);
      this.reactiveForm.get('productName')?.setValue(this.productDto?.code + ' - ' + this.productDto?.name);
      if (this.productDto.price) {
        let price = this.formatNumber('' + this.productDto?.price);
        this.reactiveForm.get('price')?.setValue(price);
      }
      // Remove temp attachments.
      this.attachments = this.attachments.filter(item => OrderAttachmentEnum.TEMP !== item.status);
      if (this.productDto.images) {
        this.productDto.images.forEach(image => {
          if (!this.attachments.find((item) => item.name === image.name)) {
            // let fileType = item.fileType;
            let orderAttachmentReqDto = new OrderAttachmentReqDto();
            orderAttachmentReqDto.url = image.url;
            orderAttachmentReqDto.name = image.name;
            // orderAttachmentReqDto.fileExtension = fileType;
            orderAttachmentReqDto.status = OrderAttachmentEnum.TEMP;

            // Save attachment.
            this.addOrderAttachment(orderAttachmentReqDto);
          }
        })
      }
    } else {
      this.reactiveForm.get('productId')?.setValue('');
      this.reactiveForm.get('productName')?.setValue('');

    }
  }
  productFilter() {
    let result = this.lstProductDto;
    let productName = this.reactiveForm.controls['productName'].value;
    if (typeof productName === 'object') {
      productName = productName.code + ' - ' + productName.name;
      this.reactiveForm.get('productName')?.setValue(productName);
    }
    if (productName) {
      result = this.lstProductDto.filter(item => {
        let display = '' + item.code?.toLowerCase() + ' - ' + item.name?.toLowerCase();
        return display.includes(productName.toLowerCase())
      });
    }

    this.lstProductDtoFiltered = result;
  }
  productFocusOut() {
    let productName = this.reactiveForm.controls['productName'].value;
    if (typeof productName === 'object') {
      productName = productName.code + ' - ' + productName.name;
      this.reactiveForm.get('productName')?.setValue(productName);
    }
    if (!productName) {
      this.reactiveForm.get('productId')?.setValue('');
    } else {
      let result = this.lstProductDto.filter(item => {
        let display = '' + item.code?.toLowerCase() + ' - ' + item.name?.toLowerCase();
        return display.includes(productName.toLowerCase())
      });
      if (result.length === 0) {
        this.reactiveForm.get('productId')?.setValue('');
        this.reactiveForm.get('productName')?.setValue('');
        const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
          height: 'auto',
          maxHeight: '90vh',
          width: 'auto',
          data: {
            title: 'Cảnh báo',
            message: 'Bạn muốn tạo mới không?'
          },
        });
        dialogRef.afterClosed().subscribe((result: boolean) => {
          if (result) {
            const dialogRef = this.dialog.originalOpen(ProductEditComponent, {
              height: 'auto',
              maxHeight: '90vh',
              width: '50vw',
              data: {
                name: productName
              },
            });

            dialogRef.afterClosed().subscribe(result => {
              // product.
              this.productDto = result;
              if (this.productDto) {
                this.reactiveForm.get('productId')?.setValue(this.productDto?.id);
                this.reactiveForm.get('productName')?.setValue(this.productDto?.code + ' - ' + this.productDto?.name);
                if (this.productDto.price) {
                  let price = this.formatNumber('' + this.productDto?.price);
                  this.reactiveForm.get('price')?.setValue(price);
                }
                // Remove temp attachments.
                this.attachments = this.attachments.filter(item => OrderAttachmentEnum.TEMP !== item.status);
                if (this.productDto.images) {
                  this.productDto.images.forEach(image => {
                    if (!this.attachments.find((item) => item.name === image.name)) {
                      // let fileType = item.fileType;
                      let orderAttachmentReqDto = new OrderAttachmentReqDto();
                      orderAttachmentReqDto.url = image.url;
                      orderAttachmentReqDto.name = image.name;
                      // orderAttachmentReqDto.fileExtension = fileType;
                      orderAttachmentReqDto.status = OrderAttachmentEnum.TEMP;

                      // Save attachment.
                      this.addOrderAttachment(orderAttachmentReqDto);
                    }
                  })
                }
                // listProduct.
                this.listProduct(true);
              }
            });
          }
        });
      }
    }
  }


  // Buyer auto complete.
  lstBuyerDtoFiltered?: CustomerDto[];
  buyerDto?: CustomerDto;
  setBuyerDto(item: CustomerDto) {
    this.buyerDto = item;
    if (this.buyerDto) {
      this.reactiveForm.get('buyerId')?.setValue(this.buyerDto.id);
      this.reactiveForm.get('buyerName')?.setValue(this.buyerDto?.fullName + ' - ' + this.buyerDto?.phoneNumber);
    } else {
      this.reactiveForm.get('buyerId')?.setValue('');
      this.reactiveForm.get('buyerName')?.setValue('');
    }
  }
  buyerFilter() {
    let result = this.lstCustomerDto;
    let buyerName = this.reactiveForm.controls['buyerName'].value;
    if (typeof buyerName === 'object') {
      buyerName = buyerName.fullName + ' - ' + buyerName.phoneNumber;
      this.reactiveForm.get('buyerName')?.setValue(buyerName);
    }
    if (buyerName) {
      result = this.lstCustomerDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase() + ' - ' + item.phoneNumber?.toLowerCase();
        return display.includes(buyerName.toLowerCase())
      });
    }

    this.lstBuyerDtoFiltered = result;
  }
  buyerFocusOut() {
    let buyerName = this.reactiveForm.controls['buyerName'].value;
    if (typeof buyerName === 'object') {
      buyerName = buyerName.fullName + ' - ' + buyerName.phoneNumber;
      this.reactiveForm.get('buyerName')?.setValue(buyerName);
    }
    if (!buyerName) {
      this.reactiveForm.get('buyerId')?.setValue('');
    } else {
      let result = this.lstCustomerDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase() + ' - ' + item.phoneNumber?.toLowerCase();
        return display.includes(buyerName.toLowerCase())
      });
      if (result.length === 0) {
        this.reactiveForm.get('buyerId')?.setValue('');
        this.reactiveForm.get('buyerName')?.setValue('');
        const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
          height: 'auto',
          maxHeight: '90vh',
          width: 'auto',
          data: {
            title: 'Cảnh báo',
            message: 'Bạn muốn tạo mới không?'
          },
        });
        dialogRef.afterClosed().subscribe((result: boolean) => {
          if (result) {
            let names = buyerName.split(' - ');
            let fullName = names[0];
            let phoneNumber = '';
            if (names.length > 1) {
              phoneNumber = names[1];
            }

            const dialogRef = this.dialog.originalOpen(CustomerEditComponent, {
              height: 'auto',
              maxHeight: '90vh',
              width: '50vw',
              data: {
                fullName: fullName,
                phoneNumber: phoneNumber,
              },
            });

            dialogRef.afterClosed().subscribe(result => {
              // buyer.
              this.buyerDto = result;
              if (this.buyerDto) {
                this.reactiveForm.get('buyerId')?.setValue(this.buyerDto.id);
                this.reactiveForm.get('buyerName')?.setValue(this.buyerDto.fullName + ' - ' + this.buyerDto.phoneNumber);
                // lstCustomer.
                this.listCustomer(true);
              }
            });
          }
        });
      }
    }
  }

  // Receiver auto complete.
  lstReceiverDtoFiltered?: CustomerDto[];
  receiverDto?: CustomerDto;
  setReceiverDto(item: CustomerDto) {
    this.receiverDto = item;
    if (this.receiverDto) {
      this.reactiveForm.get('receiverId')?.setValue(this.receiverDto.id);
      this.reactiveForm.get('receiverName')?.setValue(this.receiverDto?.fullName + ' - ' + this.receiverDto?.phoneNumber);
    } else {
      this.reactiveForm.get('receiverId')?.setValue('');
      this.reactiveForm.get('receiverName')?.setValue('');
    }
  }
  receiverFilter() {
    let result = this.lstCustomerDto;
    let receiverName = this.reactiveForm.controls['receiverName'].value;
    if (typeof receiverName === 'object') {
      receiverName = receiverName.fullName + ' - ' + receiverName.phoneNumber;
      this.reactiveForm.get('receiverName')?.setValue(receiverName);
    }
    if (receiverName) {
      result = this.lstCustomerDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase() + ' - ' + item.phoneNumber?.toLowerCase();
        return display.includes(receiverName.toLowerCase())
      });
    }

    this.lstReceiverDtoFiltered = result;
  }
  receiverFocusOut() {
    let receiverName = this.reactiveForm.controls['receiverName'].value;
    if (typeof receiverName === 'object') {
      receiverName = receiverName.fullName + ' - ' + receiverName.phoneNumber;
      this.reactiveForm.get('receiverName')?.setValue(receiverName);
    }
    if (!receiverName) {
      this.reactiveForm.get('receiverId')?.setValue('');
    } else {
      let result = this.lstCustomerDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase() + ' - ' + item.phoneNumber?.toLowerCase();
        return display.includes(receiverName.toLowerCase())
      });
      if (result.length === 0) {
        this.reactiveForm.get('receiverId')?.setValue('');
        this.reactiveForm.get('receiverName')?.setValue('');
        const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
          height: 'auto',
          maxHeight: '90vh',
          width: 'auto',
          data: {
            title: 'Cảnh báo',
            message: 'Bạn muốn tạo mới không?'
          },
        });
        dialogRef.afterClosed().subscribe((result: boolean) => {
          if (result) {
            let names = receiverName.split(' - ');
            let fullName = names[0];
            let phoneNumber = '';
            if (names.length > 1) {
              phoneNumber = names[1];
            }

            const dialogRef = this.dialog.originalOpen(CustomerEditComponent, {
              height: 'auto',
              maxHeight: '90vh',
              width: '50vw',
              data: {
                fullName: fullName,
                phoneNumber: phoneNumber,
              },
            });

            dialogRef.afterClosed().subscribe(result => {
              // receiver
              this.receiverDto = result;
              if (this.receiverDto) {
                this.reactiveForm.get('receiverId')?.setValue(this.receiverDto.id);
                this.reactiveForm.get('receiverName')?.setValue(this.receiverDto.fullName + ' - ' + this.receiverDto.phoneNumber);
                // lstCustomer.
                this.listCustomer(true);
              }
            });
          }
        });
      }
    }
  }

  // SupportedSale auto complete.
  lstSupportedSaleDtoFiltered?: AccountDto[];
  supportedSaleDto?: AccountDto;
  setSupportedSaleDto(item: AccountDto) {
    this.supportedSaleDto = item;
    if (this.supportedSaleDto) {
      this.reactiveForm.get('supportedSaleId')?.setValue(this.supportedSaleDto.id);
      this.reactiveForm.get('supportedSaleName')?.setValue(this.supportedSaleDto?.fullName);
    } else {
      this.reactiveForm.get('supportedSaleId')?.setValue('');
      this.reactiveForm.get('supportedSaleName')?.setValue('');
    }
  }
  supportedSaleFilter() {
    let result = this.lstAccountDto;
    let supportedSaleName = this.reactiveForm.controls['supportedSaleName'].value;
    if (typeof supportedSaleName === 'object') {
      supportedSaleName = supportedSaleName.fullName;
      this.reactiveForm.get('supportedSaleName')?.setValue(supportedSaleName);
    }
    if (supportedSaleName) {
      result = this.lstAccountDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase();
        return display.includes(supportedSaleName.toLowerCase())
      });
    }

    this.lstSupportedSaleDtoFiltered = result;
  }
  supportedSaleFocusOut() {
    let supportedSaleName = this.reactiveForm.controls['supportedSaleName'].value;
    if (typeof supportedSaleName === 'object') {
      supportedSaleName = supportedSaleName.fullName;
      this.reactiveForm.get('supportedSaleName')?.setValue(supportedSaleName);
    }
    if (!supportedSaleName) {
      this.reactiveForm.get('supportedSaleId')?.setValue('');
    } else {
      let result = this.lstAccountDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase();
        return display.includes(supportedSaleName.toLowerCase())
      });
      if (result.length === 0) {
        this.reactiveForm.get('supportedSaleId')?.setValue('');
        this.reactiveForm.get('supportedSaleName')?.setValue('');
      }
    }
  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.registerLocale(res.lang);
      this.dateAdapter.setLocale(res.lang);
    });

    this.attachments = this.editItem.attachments ?? [];
    this.attachments.forEach(item => item.status = OrderAttachmentEnum.DB);
    this.deleteAttachments = [];


    // lstAccount.
    this.listAccount();

    // listProduct.
    this.listProduct(false);

    // lstCustomer.
    this.listCustomer(false);
  }

  listAccount() {
    let params: any = {
      page: 0,
      size: 500,
    }
    this.accountService.listBySearch(params).subscribe(
      res => {
        this.lstAccountDto = res.items ?? [];
        this.lstSupportedSaleDtoFiltered = this.lstAccountDto;
        // Set supportedSale.
        let supportedSaleId: string = '';
        if (this.editMode) {
          supportedSaleId = this.editItem.supportedSale?.id ?? '';
        } else {
          supportedSaleId = this.userService.get().id;
        }
        this.supportedSaleDto = this.lstAccountDto.find(item => item.id === supportedSaleId);
        this.reactiveForm.controls['supportedSaleId'].setValue(supportedSaleId);
        this.reactiveForm.get('supportedSaleName')?.setValue(this.supportedSaleDto?.fullName);
      },
      () => {
      },
      () => {
      }
    );
  }

  listProduct(reload: boolean) {
    let params: any = {
      page: 0,
      size: 500,
    }
    this.productService.listBySearch(params).subscribe(
      res => {
        this.lstProductDto = res.items ?? [];
        this.lstProductDtoFiltered = this.lstProductDto;
        if (!reload && this.editMode) {
          // Set product.
          this.productDto = this.lstProductDto.find(item => item.id === this.editItem.product?.id);
          if (this.productDto) {
            this.reactiveForm.get('productName')?.setValue(this.productDto?.code + ' - ' + this.productDto?.name);
          }
        }
      },
      () => {
      },
      () => {
      }
    );
  }

  listCustomer(reload: boolean) {
    let params: any = {
      page: 0,
      size: 500,
    }
    this.customerService.listBySearch(params).subscribe(
      res => {
        this.lstCustomerDto = res.items ?? [];
        this.lstBuyerDtoFiltered = this.lstCustomerDto;
        this.lstReceiverDtoFiltered = this.lstCustomerDto;
        if (!reload && this.editMode) {
          // Set buyer.
          this.buyerDto = this.lstCustomerDto.find(item => item.id === this.editItem.buyer?.id);
          this.reactiveForm.get('buyerName')?.setValue(this.buyerDto?.fullName + ' - ' + this.buyerDto?.phoneNumber);
          // Set receiver.
          this.receiverDto = this.lstCustomerDto.find(item => item.id === this.editItem.receiver?.id);
          this.reactiveForm.get('receiverName')?.setValue(this.receiverDto?.fullName + ' - ' + this.receiverDto?.phoneNumber);
        }
      },
      () => {
      },
      () => {
      }
    );
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

  addOrderAttachment(orderAttachmentReqDto: OrderAttachmentReqDto) {
    this.attachmentService.create(orderAttachmentReqDto).subscribe(
      (imgId: string) => {
        let orderAttatchResDto = new OrderAttachmentResDto();
        orderAttatchResDto.id = imgId;
        orderAttatchResDto.url = orderAttachmentReqDto.url;
        orderAttatchResDto.name = orderAttachmentReqDto.name;
        orderAttatchResDto.fileExtension = orderAttachmentReqDto.fileExtension;
        orderAttatchResDto.uploadedBy = new AccountResDto();
        orderAttatchResDto.uploadedBy.fullName = this.userService.get().name;
        orderAttatchResDto.status = orderAttachmentReqDto.status;

        this.attachments.push({ ...orderAttatchResDto });
        this.cdr.detectChanges();
      },
      (error) => {
        this.cdr.detectChanges();
      },
      () => {
        this.cdr.detectChanges();
      }
    )
  }

  @ViewChild('chooseFiles') chooseFiles?: ElementRef;
  onChooseFiles(imgFile: any) {
    if (imgFile.target.files && imgFile.target.files[0]) {
      // Remove temp attachments.
      this.attachments = this.attachments.filter(item => OrderAttachmentEnum.TEMP !== item.status);
      Array.from(imgFile.target.files).forEach((file: any) => {
        let fileName = file.name;
        let fileType = file.type;
        if (!this.attachments.find((item) => item.name === fileName)) {
          // Upload file.
          this.imageService.upload(file).subscribe(
            (link) => {
              let orderAttachmentReqDto = new OrderAttachmentReqDto();
              orderAttachmentReqDto.url = link;
              orderAttachmentReqDto.name = fileName;
              orderAttachmentReqDto.fileExtension = fileType;

              // Save attachment.
              this.addOrderAttachment(orderAttachmentReqDto);
            },
            (imageError) => {
              console.log(imageError);
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
  deleteImage(attachment: OrderAttachmentResDto) {
    const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: null,
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.deleteAttachments.push(attachment);
        this.attachments = this.attachments.filter(item => item.id !== attachment.id);
        this.cdr.detectChanges();
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

  // Validate buyer.
  validateBuyer() {
    let display = this.buyerDto?.fullName + ' - ' + this.buyerDto?.phoneNumber;
    let buyerName = '' + this.reactiveForm.get('buyerName')?.value;
    let valid = display.toLowerCase() === buyerName.toLowerCase();

    if (!valid) {
      this.reactiveForm.get('buyerName')?.setErrors({ invalid: 'Invalid buyer name' });
    }

    return valid;
  }

  // Validate receiver.
  validateReceiver() {
    let display = this.receiverDto?.fullName + ' - ' + this.receiverDto?.phoneNumber;
    let receiverName = '' + this.reactiveForm.get('receiverName')?.value;
    let valid = display.toLowerCase() === receiverName.toLowerCase();

    if (!valid) {
      this.reactiveForm.get('receiverName')?.setErrors({ invalid: 'Invalid receiver name' });
    }

    return valid;
  }

  // Validate supportedSale.
  validateSupportedSale() {
    let display = '' + this.supportedSaleDto?.fullName;
    let supportedSaleName = '' + this.reactiveForm.get('supportedSaleName')?.value;
    let valid = display.toLowerCase() === supportedSaleName.toLowerCase();

    if (!valid) {
      this.reactiveForm.get('supportedSaleName')?.setErrors({ invalid: 'Invalid supportedSale name' });
    }

    return valid;
  }

  isError(): boolean {
    let isError = this.reactiveForm.get('code')?.hasError('required')
      || this.reactiveForm.get('price')?.hasError('required')
      || this.reactiveForm.get('depositAmount')?.hasError('required')
      || this.reactiveForm.get('source')?.hasError('required')
      || this.reactiveForm.get('status')?.hasError('required')
      || this.reactiveForm.get('deliveryDateTime')?.hasError('required')
      || this.reactiveForm.get('buyerId')?.hasError('required')
      || this.reactiveForm.get('receiverId')?.hasError('required')
      || this.reactiveForm.get('supportedSaleId')?.hasError('required')
      || !this.validateBuyer()
      || !this.validateReceiver()
      || !this.validateSupportedSale()
      ;

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      this.snackBar.open('Error!', '', { duration: 2000 });
      return;
    }

    var result;
    let price = Number.parseInt(this.unformatNumber(this.reactiveForm.controls['price'].value));
    let depositAmount = Number.parseInt(this.unformatNumber(this.reactiveForm.controls['depositAmount'].value));
    if (this.editMode) {
      let orderUpdateDto: OrderUpdateReqDto = {
        version: this.editItem.version,
        code: this.editItem.code,
        productId: this.reactiveForm.controls['productId'].value,
        price: price,
        source: this.reactiveForm.controls['source'].value,
        deliveryDateTime: this.datePipe.transform(this.reactiveForm.controls['deliveryDateTime'].value, 'yyyy-MM-dd HH:mm:ss') ?? '',
        customerMessage: this.reactiveForm.controls['customerMessage'].value,
        noteForShipper: this.reactiveForm.controls['noteForShipper'].value,
        noteForFlorist: this.reactiveForm.controls['noteForFlorist'].value,
        buyerId: this.reactiveForm.controls['buyerId'].value,
        receiverId: this.reactiveForm.controls['receiverId'].value,
        supportedSaleId: this.reactiveForm.controls['supportedSaleId'].value,
      }
      // deposit.
      let deposit = new OrderPaymentReq();
      deposit.id = this.editItem.deposit?.id;
      deposit.type = PaymentTypeEnum[this.editItem.deposit?.type as keyof typeof PaymentTypeEnum];
      if (!deposit.type) {
        deposit.type = PaymentTypeEnum.CASH;
      }
      deposit.amount = depositAmount;
      deposit.moneyKeeperId = this.editItem.deposit?.moneyKeeper?.id;
      deposit.note = this.editItem.deposit?.note;
      deposit.attachmentIds = this.editItem.deposit?.attachments?.map(item => item.id ?? '');
      orderUpdateDto.deposit = deposit;
      // attachments: delete.
      this.deleteAttachments.forEach(attachment => {
        if (OrderAttachmentEnum.DB == attachment.status) {
          this.attachmentService.delete(attachment.id ?? '').subscribe(
            (response: any) => {
              this.cdr.detectChanges();
            },
            (error: any) => {
              this.cdr.detectChanges();
            }
          );
        }
      })
      // attachments: add.
      let addAttachmentIds: string[] = this.attachments
        .filter(item => OrderAttachmentEnum.DB !== item.status)
        .map(item => item.id ?? '');
      if (addAttachmentIds.length > 0) {
        this.orderService.addImagesToOrder(this.editItem.id ?? '', addAttachmentIds).subscribe(
          (response) => {
            this.cdr.detectChanges();
          },
          (error) => {
            this.cdr.detectChanges();
          }
        );
      }

      // Update.
      result = this.orderService.update(this.editItem.id ?? '', orderUpdateDto);
    } else {
      let orderCreateDto: OrderCreateReqDto = {
        productId: this.reactiveForm.controls['productId'].value,
        price: price,
        source: this.reactiveForm.controls['source'].value,
        deliveryDateTime: this.datePipe.transform(this.reactiveForm.controls['deliveryDateTime'].value, 'yyyy-MM-dd HH:mm:ss') ?? '',
        customerMessage: this.reactiveForm.controls['customerMessage'].value,
        noteForShipper: this.reactiveForm.controls['noteForShipper'].value,
        noteForFlorist: this.reactiveForm.controls['noteForFlorist'].value,
        buyerId: this.reactiveForm.controls['buyerId'].value,
        receiverId: this.reactiveForm.controls['receiverId'].value,
        supportedSaleId: this.reactiveForm.controls['supportedSaleId'].value,
      }
      let deposit = new OrderPaymentReq();
      deposit.type = PaymentTypeEnum.CASH;
      deposit.amount = depositAmount;
      deposit.moneyKeeperId = this.userService.get().id;
      orderCreateDto.deposit = deposit;
      // attachments.
      orderCreateDto.attachmentIds = this.attachments.map(item => item.id ?? '');
      // Create.
      result = this.orderService.create(orderCreateDto);
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

  createProduct(data: ProductResDto) {
    const dialogRef = this.dialog.originalOpen(ProductEditComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '50vw',
      data: data,
    });

    dialogRef.afterClosed().subscribe(() => {
      // listProduct.
      this.listProduct(true);
    });
  }

  createCustomer(data: CustomerDto) {
    const dialogRef = this.dialog.originalOpen(CustomerEditComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '50vw',
      data: data,
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      // lstCustomer.
      this.listCustomer(true);
    });
  }

  onClose(): void {
    this.dialogRef.close();
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

}
