import { DatePipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, LOCALE_ID, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { User } from '@core';
import { UserService } from '@core/authentication/user.service';
import { SettingsService } from '@core/bootstrap/settings.service';
import { TranslateService } from '@ngx-translate/core';
import { OrderSource } from '@shared/constants/order-source.enum';
import { OrderStatusEnum } from '@shared/constants/order-status.enum';
import { OrderResDto } from 'app/dto/order-res.dto';
import { OrderStatusDto } from 'app/dto/order-status.dto';
import { OrderDto } from 'app/dto/order.dto';
import { UpdateOrderStatusReqDto } from 'app/dto/update-order-status-req.dto';
import { AccountService } from 'app/services/account.service';
import { OrderService } from 'app/services/order.service';
import { Subscription } from 'rxjs';


@Component({
  selector: 'page-order-status',
  templateUrl: './order-status.component.html',
  styleUrls: ['./order-status.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    OrderService,
    DatePipe,
  ],
})
export class OrderStatusComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  editItem: OrderResDto = new OrderResDto();
  editMode: boolean = false;
  minPaymentDate: Date = new Date(Date.now() + 0 * 60 * 60 * 1000); // 0 hour.
  lstOrderSource: OrderSource[] = [OrderSource.HCM, OrderSource.OTHER];
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
  roles: string[] = [];

  // orderStatus = OrderStatus;
  unsort(a: any, b: any) {
    return 1;
  }

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private translate: TranslateService,
    public dialogRef: MatDialogRef<OrderStatusComponent>,
    private settings: SettingsService,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,

    private datePipe: DatePipe,
    private userService: UserService,
    private accountService: AccountService,
    private orderService: OrderService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;

    this.editItem = data;

    this.reactiveForm = this.fb.group({
      code: [{ value: this.editItem.code, disabled: true }],
      status: [this.editItem.status, [this.editMode? Validators.required : () => null]],
    });

    let user: User = this.userService.get();
    this.roles = user.roles ?? [];
    
    if (this.roles.indexOf('FLORIST_PRIVILEGE') > -1) {
      this.lstOrderStatusDto = this.lstOrderStatusDto.filter(item => item.value && [OrderStatusEnum.DOING, OrderStatusEnum.DONE].indexOf(item.value) > -1)
    }
    else if (this.roles.indexOf('SHIPPER_PRIVILEGE') > -1) {
      this.lstOrderStatusDto = this.lstOrderStatusDto.filter(item => item.value && [OrderStatusEnum.SHIPPING, OrderStatusEnum.CUSTOMER_SATISFIED].indexOf(item.value) > -1)
    }

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
      this.registerLocale(res.lang);
    });
  }

  getErrorMessage(form: FormGroup) {
    return form.get('email')?.hasError('required')
      ? 'validations.required'
      : form.get('email')?.hasError('email')
        ? 'validations.invalid_email'
        : '';
  }

  isError(): boolean {
    let isError = this.reactiveForm.get('code')?.hasError('required')
      || this.reactiveForm.get('status')?.hasError('required')
      ;

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      this.snackBar.open('Error!', '', { duration: 2000 });
      return;
    }

    const orderStatus =  this.reactiveForm.get('status')?.value;
    let updateOrderStatusReqDto = new UpdateOrderStatusReqDto();
    updateOrderStatusReqDto.status = orderStatus;
    updateOrderStatusReqDto.version = this.editItem.version;
    // Update.
    this.orderService.updateOrderStatus(this.editItem.id ?? '', updateOrderStatusReqDto)
    .subscribe(
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

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

}
