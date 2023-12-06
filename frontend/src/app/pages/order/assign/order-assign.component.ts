import { DatePipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, LOCALE_ID, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { UserService } from '@core/authentication/user.service';
import { SettingsService } from '@core/bootstrap/settings.service';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { OrderSource } from '@shared/constants/order-source.enum';
import { AccountDto } from 'app/dto/account.dto';
import { OrderPaymentHistoryRes } from 'app/dto/order-payment-history-res.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { OrderUpdateReqDto } from 'app/dto/order-update-req.dto';
import { AccountService } from 'app/services/account.service';
import { OrderService } from 'app/services/order.service';
import { Subscription } from 'rxjs';


@Component({
  selector: 'page-order-assign',
  templateUrl: './order-assign.component.html',
  styleUrls: ['./order-assign.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    OrderService,
    DatePipe,
  ],
})
export class OrderAssignComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  editItem: OrderResDto = new OrderResDto();
  editMode: boolean = false;
  editId?: string;

  minPaymentDate: Date = new Date(Date.now() + 0 * 60 * 60 * 1000); // 0 hour.
  lstOrderSource: OrderSource[] = [OrderSource.HCM, OrderSource.OTHER];
  lstAccountDto: AccountDto[] = [];

  columns: MtxGridColumn[] = [
    {
      header: 'STT',
      field: 'index1',
      sortable: false,
      disabled: true,
      width: '5px',
      minWidth: 5,
      maxWidth: 20,
    },
    {
      header: "Ngày giờ chuyển đơn",
      field: 'createdOn',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: "Người giữ đơn",
      field: 'personInCharse.fullName',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
  ];
  list: OrderPaymentHistoryRes[];
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
  query = { ...this.defaultQuery };

  get params() {
    const p = Object.assign({}, this.query);
    // p.page += 1;
    return p;
  }

  constructor(
    public _MatPaginatorIntl: MatPaginatorIntl,
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private translate: TranslateService,
    public dialogRef: MatDialogRef<OrderAssignComponent>,
    private settings: SettingsService,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: OrderResDto,

    private userService: UserService,
    private datePipe: DatePipe,
    private accountService: AccountService,
    private orderService: OrderService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;

    this.editItem = data;
    this.list = data.assignmentHistories ?? [];
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
      // code: [this.editItem.code, [this.editMode? Validators.required : () => null]],
      code: [{ value: this.editItem.code, disabled: true }],
      supportedSaleId: ['', [Validators.required]],
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

  // SupportedSale auto complete.
  lstSupportedSaleDtoFiltered?: AccountDto[];
  supportedSaleDto?: AccountDto;
  setSupportedSaleDto(item: AccountDto) {
    this.supportedSaleDto = item;
    let supportedSaleId;
    if (this.supportedSaleDto) {
      supportedSaleId = this.supportedSaleDto.id;
    }
    this.reactiveForm.controls['supportedSaleId'].setValue(supportedSaleId);
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
        let display = '' + item.username?.toLowerCase();
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
    });

    let params: any = {
      page: 0,
      size: 500,
    }

    // lstAccount.
    this.accountService.listBySearch(params).subscribe(
      res => {
        this.lstAccountDto = res.items ?? [];
        this.lstSupportedSaleDtoFiltered = this.lstAccountDto;
        // // Set supportedSale.
        // let supportedSaleId = this.editItem.supportedSale?.id;
        // if (this.editItem.assignmentHistories && this.editItem.assignmentHistories.length > 0) {
        //   supportedSaleId = this.editItem.assignmentHistories[this.editItem.assignmentHistories.length - 1].personInCharse?.id;
        // }
        // this.supportedSaleDto = this.lstAccountDto.find(item => item.id === supportedSaleId);
        // this.reactiveForm.get('supportedSaleId')?.setValue(this.supportedSaleDto?.id);
        // this.reactiveForm.get('supportedSaleName')?.setValue(this.supportedSaleDto?.username);
      },
      () => {
      },
      () => {
      }
    );
  }

  getErrorMessage(form: FormGroup) {
    return form.get('email')?.hasError('required')
      ? 'validations.required'
      : form.get('email')?.hasError('email')
        ? 'validations.invalid_email'
        : '';
  }

  // Validate supportedSale.
  validateSupportedSale() {
    let display = '' + this.supportedSaleDto?.fullName;
    let supportedSaleName = this.reactiveForm.get('supportedSaleName')?.value;
    if (typeof supportedSaleName === 'object') {
      supportedSaleName = supportedSaleName.fullName;
    }
    let valid = display.toLowerCase() === ('' + supportedSaleName).toLowerCase();

    if (!valid) {
      this.reactiveForm.get('supportedSaleName')?.setErrors({ invalid: 'Invalid supportedSale name' });
    }

    return valid;
  }

  isError(): boolean {
    let isError = this.reactiveForm.get('code')?.hasError('required')
      || this.reactiveForm.get('supportedSaleId')?.hasError('required')
      || !this.validateSupportedSale()
      ;

    return isError ?? true;
  }

  convertOrderToUpdate(orderResDto: OrderResDto): OrderUpdateReqDto {
    const orderUpdateReqDto = new OrderUpdateReqDto();
    // Object.keys(orderUpdateReqDto).forEach(key => {
    //   const value = orderResDto[key as keyof OrderUpdateReqDto];
    //   if (value !== undefined && orderUpdateReqDto[key as keyof OrderUpdateReqDto] !== undefined) {
    //     orderUpdateReqDto[key as keyof OrderUpdateReqDto] = undefined;
    //   }
    // })

    Object.assign(orderUpdateReqDto, orderResDto)
    // return.
    return orderUpdateReqDto;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      this.snackBar.open('Error!', '', { duration: 2000 });
      return;
    }

    let supportedSaleId = this.reactiveForm.controls['supportedSaleId'].value;
    // Update.
    this.orderService.reAssignedOrderTo(this.editItem.id ?? '', supportedSaleId)
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
    this.query = { ...this.defaultQuery };
  }

  // createNew() {
  //   this.editMode = false;
  //   this.editId = '';
  //   this.reactiveForm.get('supportedSaleId')?.setValue(this.userService.get().id);
  //   this.reactiveForm.get('supportedSaleName')?.setValue(this.supportedSaleDto?.username);
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
