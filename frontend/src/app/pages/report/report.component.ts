import { DatePipe, DecimalPipe, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectorRef, Inject } from '@angular/core';
import { ViewChild } from '@angular/core';
import { LOCALE_ID } from '@angular/core';
import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MomentDateAdapter, MAT_MOMENT_DATE_ADAPTER_OPTIONS, MAT_MOMENT_DATE_FORMATS } from '@angular/material-moment-adapter';
import { MAT_DATE_LOCALE, MAT_DATE_FORMATS, DateAdapter } from '@angular/material/core';
import { PageEvent } from '@angular/material/paginator';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { TranslateService } from '@ngx-translate/core';
import { OrderStatusEnum } from '@shared/constants/order-status.enum';
import { CommonUtil } from '@shared/utils/common-util';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AccountDto } from 'app/dto/account.dto';
import { CustomerDto } from 'app/dto/customer.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { OrderStatusStatisticResDto } from 'app/dto/order-status-statistic-res.dto';
import { OrderStatusDto } from 'app/dto/order-status.dto';
import { ProfitReportResDto } from 'app/dto/profit-report-res.dto';
import { ShipperStatisticResDto } from 'app/dto/shipper-statistic-res.dto';
import { AccountService } from 'app/services/account.service';
import { CustomerService } from 'app/services/customer.service';
import { OrderService } from 'app/services/order.service';
import { ReportService } from 'app/services/report.service';
import { ChartDataset, ChartOptions, ChartType } from 'chart.js';
import * as moment from 'moment';
import { Observable } from 'rx';
import { of, Subscription } from 'rxjs';


@Component({
  selector: 'page-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.scss'],
  providers: [
    OrderService,
    DatePipe,
    DecimalPipe,
    {
      provide: DateAdapter,
      useClass: MomentDateAdapter,
      deps: [MAT_DATE_LOCALE, MAT_MOMENT_DATE_ADAPTER_OPTIONS]
    },
    { provide: MAT_DATE_FORMATS, useValue: MAT_MOMENT_DATE_FORMATS },
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ReportComponent implements OnInit {
  path: string = '';
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  searchForm: FormGroup;
  list: OrderResDto[] = [];
  total = 0;
  isLoading = true;
  lstAccountDto: AccountDto[] = [];
  lstCustomerDto: CustomerDto[] = [];
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
  lstOrderStatusStatisticResDto?: OrderStatusStatisticResDto[];
  lstProfitReportResDto?: ProfitReportResDto[];
  lstShipperStatisticResDto?: ShipperStatisticResDto[];

  getStatusNumber(status: string) {
    return this.lstOrderStatusDto.find(item => item.value === status)?.quantity;
  }

  unsort(a: any, b: any) {
    return 1;
  }

  public currentDate?: moment.Moment = moment();
  @ViewChild('picker') picker: any;
  public minDate?: moment.Moment;
  public maxDate?: moment.Moment;


  public barChartOptions: ChartOptions = {
    responsive: true,
  };
  public barChartLabels: string[] = [];
  public barChartType: ChartType = 'bar';
  public barChartLegend = true;
  public barChartPlugins = [];

  public barChartData: ChartDataset[] = [];

  statusChanged(event?: any) {
  }

  defaultQuery = {
    page: 0,
    size: 10,
    accountId: '',
    from: '',
    to: '',
    sortBy: 'createdOn',
    ascDirection: '0',
  };
  query = { ...this.defaultQuery };

  get params() {
    this.query.accountId = this.searchForm.controls['accountId'].value;
    this.query.from = this.datePipe.transform(this.searchForm.controls['from'].value, 'yyyy-MM-dd') ?? '';
    this.query.to = this.datePipe.transform(this.searchForm.controls['to'].value, 'yyyy-MM-dd') ?? '';

    const params = Object.assign({}, this.query);
    // params.page += 1;
    return params;
  }

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private settings: SettingsService,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialog: MtxDialog,
    private cdr: ChangeDetectorRef,
    private datePipe: DatePipe,
    private decimalPipe: DecimalPipe,
    private dateAdapter: DateAdapter<any>,

    private accountService: AccountService,
    private customerService: CustomerService,
    private orderService: OrderService,
    private reportService: ReportService,
  ) {
    this.path = this.route.routeConfig?.path ?? '';
    this.registerLocale(this.settings.getLanguage());
    this.dateAdapter.setLocale(this.settings.getLanguage());

    this.searchForm = this.fb.group({
      // code: [this.editItem.code, [this.editMode? Validators.required : () => null]],
      code: [''],
      status: [''],
      buyerPhoneNumber: [''],
      receiverPhoneNumber: [''],
      createdSaleId: [''],
      accountId: [''],
      accountName: [''],
      from: [null],
      to: [null],
    });
  }

  // Account auto complete.
  lstAccountDtoFiltered?: AccountDto[];
  accountDto?: AccountDto;
  setAccountDto(item: AccountDto) {
    this.accountDto = item;
    let accountId;
    if (this.accountDto) {
      accountId = this.accountDto.id;
    }
    this.searchForm.controls['accountId'].setValue(accountId);
  }
  accountFilter() {
    let result = this.lstAccountDto;
    let accountName = this.searchForm.controls['accountName'].value;
    if (typeof accountName === 'object') {
      accountName = accountName.fullName;
      this.searchForm.get('accountName')?.setValue(accountName);
    }
    if (accountName) {
      result = this.lstAccountDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase();
        return display.includes(accountName.toLowerCase())
      });
    }

    this.lstAccountDtoFiltered = result;
  }
  accountFocusOut() {
    let accountName = this.searchForm.controls['accountName'].value;
    if (typeof accountName === 'object') {
      accountName = accountName.fullName;
      this.searchForm.get('accountName')?.setValue(accountName);
    }
    if (!accountName) {
      this.searchForm.get('accountId')?.setValue('');
    } else {
      let result = this.lstAccountDto.filter(item => {
        let display = '' + item.fullName?.toLowerCase();
        return display.includes(accountName.toLowerCase())
      });
      if (result.length === 0) {
        this.searchForm.get('accountId')?.setValue('');
        this.searchForm.get('accountName')?.setValue('');
      }
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
      this.dateAdapter.setLocale(res.lang);
      this.getList();
    });

    // Capture the access token and code
    this.route
      .queryParams
      .subscribe((code: any) => {
        // console.log(code);
      });

    let params: any = {
      page: 0,
      size: 500,
    }

    // lstAccount.
    this.accountService.listBySearch(params).subscribe(
      res => {
        this.lstAccountDto = res.items ?? [];
        this.lstAccountDtoFiltered = this.lstAccountDto;
      },
      () => {
      },
      () => {
      }
    );

    // lstCustomer.
    this.customerService.listBySearch(params).subscribe(
      res => {
        this.lstCustomerDto = res.items ?? [];
      },
      () => {
      },
      () => {
      }
    );

    // this.getList();
    this.isLoading = false;
  }

  getList() {
    this.isLoading = true;
    let params = CommonUtil.removeEmptyValues(this.params);
    // profits.
    if (this.path === 'report/profits') {
      this.reportService.profits(params).subscribe(
        res => {
          // accountName.
          let accountName = this.searchForm.get('accountName')?.value;
          if (typeof accountName === 'object') {
            accountName = accountName.fullName;
          }
          this.lstProfitReportResDto = res.data ?? [];
          this.barChartLabels = this.lstProfitReportResDto.map(item => item.reportDate ?? '');
          let data = this.lstProfitReportResDto.map(item => item.profit ?? 0);
          this.barChartData = [
            { data: data, label: accountName }
          ]
          this.isLoading = false;
          this.cdr.detectChanges();
        },
        () => {
          this.isLoading = false;
          this.cdr.detectChanges();
        },
        () => {
          this.isLoading = false;
          this.cdr.detectChanges();
        }
      );
      return;
    }
    // shipper.
    if (this.path === 'report/shipper') {
      this.reportService.shipperStatistic(params).subscribe(
        res => {
          this.lstShipperStatisticResDto = res.data ?? [];
          this.barChartLabels = [];
          let shippers: AccountResDto[] = [];
          let reportShippers: any[] = [];
          let accountId = this.searchForm.get('accountId')?.value;
          if (accountId) {
            let accountName = this.searchForm.get('accountName')?.value;
            if (typeof accountName === 'object') {
              accountName = accountName.fullName;
            }
            reportShippers.push({ id: accountId, data: [], label: accountName });
          } else {
            for (let index = 0; index < this.lstShipperStatisticResDto.length; index++) {
              let shipperStatistic = this.lstShipperStatisticResDto[index];
              if (shipperStatistic.data) {
                shipperStatistic.data.forEach(item1 => {
                  if (shippers.filter(shipper => shipper.id == item1.shipper?.id).length === 0) {
                    if (item1.shipper) {
                      shippers.push(item1.shipper);
                    }
                  }
                })
              }
            };
            for (let index = 0; index < shippers.length; index++) {
              reportShippers.push({ id: shippers[index].id, data: [], label: shippers[index].fullName });
            }
          }
          // loop each day.
          for (let index = 0; index < this.lstShipperStatisticResDto.length; index++) {
            let shipperStatisticDay = this.lstShipperStatisticResDto[index];
            if (shipperStatisticDay.data) {
              this.barChartLabels.push(shipperStatisticDay.reportDate ?? '');
              // loop each report shipper.
              for (let index1 = 0; index1 < reportShippers.length; index1++) {
                let reportShipper = reportShippers[index1];
                let numberOfKm = 0;
                if (accountId) {
                  numberOfKm = shipperStatisticDay.data[0].numberOfKm ?? 0;
                } else {
                  // find shipper.
                  let shipperData = shipperStatisticDay.data.filter(item => item.shipper?.id == reportShipper.id);
                  if (shipperData.length > 0) {
                    numberOfKm = shipperData[0].numberOfKm ?? 0;
                  }
                }
                reportShipper.data.push(numberOfKm);
              }
            }
          }
          this.barChartData = reportShippers;
          this.isLoading = false;
          this.cdr.detectChanges();
        },
        () => {
          this.isLoading = false;
          this.cdr.detectChanges();
        },
        () => {
          this.isLoading = false;
          this.cdr.detectChanges();
        }
      );
      return;
    }
  }

  pageChanged(event?: PageEvent) {
    // console.log(event);
  }

  search() {
    let orderStatus = this.searchForm.controls['status'].value;

    this.query.page = 0;
    this.getList();
  }

  reset() {
    this.searchForm.controls['accountId'].setValue('');
    this.searchForm.controls['accountName'].setValue('');
    this.searchForm.controls['from'].setValue(null);
    this.searchForm.controls['to'].setValue(null);

    this.query = { ...this.defaultQuery };
    this.getList();
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

}
