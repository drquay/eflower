import { DatePipe, DecimalPipe, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import {
  MAT_MOMENT_DATE_ADAPTER_OPTIONS, MAT_MOMENT_DATE_FORMATS,
  MomentDateAdapter
} from '@angular/material-moment-adapter';
import { DateAdapter, MAT_DATE_FORMATS, MAT_DATE_LOCALE } from '@angular/material/core';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MatTabChangeEvent } from '@angular/material/tabs/tab-group';
import { ActivatedRoute } from '@angular/router';
import { User } from '@core';
import { UserService } from '@core/authentication/user.service';
import { SettingsService } from '@core/bootstrap/settings.service';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { OrderSource } from '@shared/constants/order-source.enum';
import { OrderStatusEnum } from '@shared/constants/order-status.enum';
import { CommonUtil } from '@shared/utils/common-util';
import { AccountDto } from 'app/dto/account.dto';
import { CustomerDto } from 'app/dto/customer.dto';
import { OrderResDto } from 'app/dto/order-res.dto';
import { OrderSourceDto } from 'app/dto/order-source.dto';
import { OrderStatusStatisticResDto } from 'app/dto/order-status-statistic-res.dto';
import { OrderStatusDto } from 'app/dto/order-status.dto';
import { AccountService } from 'app/services/account.service';
import { CustomerService } from 'app/services/customer.service';
import { OrderService } from 'app/services/order.service';
import { ReportService } from 'app/services/report.service';
import * as moment from 'moment';
import { of, Subscription } from 'rxjs';
import { OrderAssignComponent } from './assign/order-assign.component';
import { OrderCommentComponent } from './comment/comment.component';
import { OrderEditComponent } from './edit/order-edit.component';
import { ImageEditComponent } from './image/image-edit.component';
import { OrderPaymentComponent } from './payment/payment.component';
import { OrderStatusComponent } from './status/order-status.component';


@Component({
  selector: 'page-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss'],
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
export class OrderComponent implements OnInit {
  path: string = '';
  isAdmin = false;
  isFlorist = false;
  isShipper = false;
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  searchForm: FormGroup;
  columns: MtxGridColumn[] = [];
  list: OrderResDto[] = [];
  total = 0;
  isLoading = true;
  lstOrderSourceDto: OrderSourceDto[] = [
    { value: OrderSource.HCM, name: "Hồ chí minh" },
    { value: OrderSource.OTHER, name: "Đơn tỉnh" },
    { value: OrderSource.AGENT, name: "Đối tác" },
  ];
  // lstAccountDto: AccountDto[] = [];
  // lstCustomerDto: CustomerDto[] = [];
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

  isCreateNew = false;
  isDispatcherRole = false;
  supportedSaleId?: string = '';
  disableSupportedSaleId = false;
  // "PRI_ADMIN", "ADMINISTRATOR_PRIVILEGE",
  // "PRI_SALE", "SALE_PRIVILEGE",
  // "PRI_FLORIST", "FLORIST_PRIVILEGE",
  // "PRI_SHIPPER", "SHIPPER_PRIVILEGE"
  lstRolesDto: any[] = [
    { value: 'FLORIST', name: 'Thợ' },
    { value: 'SHIPPER', name: 'Người giao hàng' },
    { value: 'SALE', name: 'Nhân viên sale' },
    { value: 'ADMIN', name: 'Admin' }
  ];
  roles: string[] = [];

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

  selectedTabIndex = 1;
  // Standard tabs demo
  tabs = [
    {
      value: '',
      label: 'Tất cả',
      disabled: false
    },
    {
      value: 'NEW',
      label: 'Đơn mới',
      disabled: false
    },
    {
      value: 'DOING',
      label: 'Đang làm',
      disabled: false
    },
    {
      value: 'DONE',
      label: 'Làm xong',
      disabled: false
    },
    {
      value: 'CUSTOMER_SATISFIED',
      label: 'Khách đồng ý',
      disabled: false
    },
    {
      value: 'CUSTOMER_REJECTED',
      label: 'Khách từ chối',
      disabled: false
    },
    {
      value: 'SALE_REJECTED',
      label: 'Hủy đơn',
      disabled: false
    },
    {
      value: 'SHIPPING',
      label: 'Đang giao',
      disabled: false
    },
    {
      value: 'SHIPPED_WITH_PAYMENT',
      label: 'Giao có tiền',
      disabled: false
    },
    {
      value: 'SHIPPED_WITH_NONPAYMENT',
      label: 'Giao không tiền',
      disabled: false
    },
    {
      value: 'ERROR',
      label: 'Gặp sự cố',
      disabled: false
    },
    {
      value: 'FINISHED',
      label: 'Hoàn tất',
      disabled: false
    },
  ];

  tabChanged(event?: MatTabChangeEvent) {
    // console.log(event);
    var index = event?.index ?? 0;
    var tab = this.tabs[index]
    this.searchForm.controls['status'].setValue(tab.value);
    this.getList();
  }

  statusChanged(event?: any) {
  }

  multiSelectable = false;
  rowSelectable = false;
  hideRowSelectionCheckbox = false;
  showToolbar = false;
  columnHideable = true;
  columnMovable = true;
  rowHover = false;
  rowStriped = true;
  pageOnFront = false;
  showPaginator = true;
  expandable = false;
  columnResizable = false;

  defaultQuery = {
    page: 0,
    size: 5,
    code: '',
    status: OrderStatusEnum.NEW,
    receiverPhoneNumber: '',
    buyerPhoneNumber: '',
    createdSaleId: '',
    supportedSaleId: '',
    deliveryFromDateTime: '',
    deliveryToDateTime: '',
    sortBy: 'createdOn',
    ascDirection: '0',
  };
  query = { ...this.defaultQuery };

  get params() {
    this.query.code = this.searchForm.controls['code'].value;
    this.query.status = this.searchForm.controls['status'].value;
    this.query.buyerPhoneNumber = this.searchForm.controls['buyerPhoneNumber'].value;
    this.query.receiverPhoneNumber = this.searchForm.controls['receiverPhoneNumber'].value;

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
    public _MatPaginatorIntl: MatPaginatorIntl,

    private userService: UserService,
    private accountService: AccountService,
    private customerService: CustomerService,
    private orderService: OrderService,
    private reportService: ReportService,
  ) {
    this.path = this.route.routeConfig?.path ?? '';
    this.registerLocale(this.settings.getLanguage());
    this.dateAdapter.setLocale(this.settings.getLanguage());

    let user: User = this.userService.get();
    this.roles = user.roles ?? [];

    // todo: FLORIST_PRIVILEGE
    // this.roles = ['FLORIST_PRIVILEGE'];

    if (
      this.roles.indexOf('ADMINISTRATOR_PRIVILEGE') > -1
      || this.roles.indexOf('SALE_ADMIN_PRIVILEGE') > -1
      || this.roles.indexOf('SALE_PRIVILEGE') > -1
      || this.roles.indexOf('PROVINCIAL_ORDER_MANAGER_PRIVILEGE') > -1
      // || this.roles.indexOf('DISPATCHERS_PRIVILEGE') > -1
    ) {
      this.isCreateNew = true;
      this.disableSupportedSaleId = false;
    }
    else if (this.roles.indexOf('DISPATCHERS_PRIVILEGE') > -1) {
      this.tabs = this.tabs.filter(item => ['', 'CUSTOMER_SATISFIED', 'CUSTOMER_REJECTED', 'SALE_REJECTED', 'SHIPPING', 'SHIPPED_WITH_PAYMENT', 'SHIPPED_WITH_NONPAYMENT', 'ERROR', 'FINISHED'].indexOf(item.value) > -1)
    }
    else if (this.roles.indexOf('FLORIST_PRIVILEGE') > -1) {
      this.isCreateNew = false;
      this.supportedSaleId = '' + user.id ?? '';
      this.disableSupportedSaleId = true;
      this.tabs = this.tabs.filter(item => ['', 'NEW', 'DOING', 'DONE', 'CUSTOMER_SATISFIED', 'ERROR', 'FINISHED'].indexOf(item.value) > -1)
    }
    else if (this.roles.indexOf('SHIPPER_PRIVILEGE') > -1) {
      this.isCreateNew = false;
      this.supportedSaleId = '' + user.id ?? '';
      this.disableSupportedSaleId = true;
      this.tabs = this.tabs.filter(item => ['', 'DONE', 'SHIPPING', 'CUSTOMER_SATISFIED', 'ERROR', 'FINISHED'].indexOf(item.value) > -1)
    }

    this.isAdmin = this.roles.indexOf('ADMINISTRATOR_PRIVILEGE') > -1 || this.roles.indexOf('SALE_ADMIN_PRIVILEGE') > -1;
    this.isDispatcherRole = this.roles.indexOf('DISPATCHERS_PRIVILEGE') > -1;
    this.isFlorist = this.roles.indexOf('FLORIST_PRIVILEGE') > -1;
    this.isShipper = this.roles.indexOf('SHIPPER_PRIVILEGE') > -1;
    this.initListColumns();

    this.searchForm = this.fb.group({
      // code: [this.editItem.code, [this.editMode? Validators.required : () => null]],
      code: [''],
      status: [OrderStatusEnum.NEW],
      buyerPhoneNumber: [''],
      receiverPhoneNumber: [''],
      createdSaleId: [''],
      supportedSaleId: [{ value: this.supportedSaleId, disabled: this.disableSupportedSaleId }],
      deliveryFromDateTime: [null],
      deliveryToDateTime: [null],
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

  initListColumns() {
    this.columns = [
      {
        header: this.translate.stream('pages.order.index1'),
        field: 'index1',
        sortable: false,
        disabled: true,
        width: '5px',
        minWidth: 5,
        maxWidth: 20,
      },
      {
        header: this.translate.stream('pages.order.code'),
        field: 'code',
        sortable: false,
        disabled: true,
        minWidth: 100,
        pinned: 'left',
      },
      {
        header: this.translate.stream('pages.order.productId'),
        field: 'product.code',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist || this.isShipper,
      },
      {
        header: this.translate.stream('pages.order.price'),
        field: 'price',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist || this.isShipper,
      },
      {
        header: this.translate.stream('pages.order.deposit'),
        field: 'deposit.amount',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist || this.isShipper,
      },
      {
        header: this.translate.stream('pages.order.source'),
        field: 'sourceName',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist || this.isShipper,
      },
      {
        header: this.translate.stream('pages.order.status'),
        field: 'statusName',
        sortable: false,
        disabled: true,
        minWidth: 100,
      },
      {
        header: this.translate.stream('pages.order.deliveryDateTime'),
        field: 'deliveryDateTime',
        sortable: false,
        disabled: true,
        minWidth: 100,
      },
      // {
      //   header: this.translate.stream('pages.order.customerMessage'),
      //   field: 'customerMessage',
      //   sortable: false,
      //   disabled: true,
      //   minWidth: 100,
      // },
      // {
      //   header: this.translate.stream('pages.order.noteForFlorist'),
      //   field: 'noteForFlorist',
      //   sortable: false,
      //   disabled: true,
      //   minWidth: 100,
      //   hide: this.isShipper,
      // },
      // {
      //   header: this.translate.stream('pages.order.noteForShipper'),
      //   field: 'noteForShipper',
      //   sortable: false,
      //   disabled: true,
      //   minWidth: 100,
      //   hide: this.isFlorist,
      // },
      {
        header: this.translate.stream('pages.order.buyerName'),
        field: 'buyerName',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist,
      },
      {
        header: this.translate.stream('pages.order.receiverName'),
        field: 'receiverName',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist,
      },
      {
        header: this.translate.stream('pages.order.supportedSaleName'),
        field: 'supportedSale.fullName',
        sortable: false,
        disabled: true,
        minWidth: 100,
        hide: this.isFlorist || this.isShipper,
      },
      {
        header: this.translate.stream('common.operation'),
        field: 'operation',
        minWidth: 120,
        width: '20rem',
        pinned: 'right',
        type: 'button',
        buttons: [
          {
            type: 'icon',
            icon: 'edit',
            tooltip: this.translate.stream('common.edit'),
            click: record => this.edit(record),
            disabled: this.isFlorist || this.isShipper,
          },
          {
            type: 'icon',
            icon: 'payment',
            tooltip: 'Thanh toán',
            click: record => this.payment(record),
          },
          {
            type: 'icon',
            icon: 'image',
            tooltip: 'Xem ảnh',
            click: record => this.preview(record),
          },
          {
            type: 'icon',
            icon: 'assignment_ind',
            tooltip: 'Chuyển giao',
            click: record => this.assign(record),
          },
          {
            type: 'icon',
            icon: 'hourglass_full',
            tooltip: 'Trạng thái',
            click: record => this.updateStatus(record),
          },
          {
            type: 'icon',
            icon: 'comment',
            tooltip: 'Ghi chú',
            click: record => this.comment(record),
          },
          {
            color: 'warn',
            icon: 'delete',
            text: this.translate.stream('common.delete'),
            tooltip: this.translate.stream('common.delete'),
            click: record => this.delete(record.id),
            disabled: !this.isAdmin,
          },
        ],
      },
    ];
  }

  ngOnInit() {
    this._MatPaginatorIntl.itemsPerPageLabel = 'Số dòng trên trang';
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

    // // lstAccount.
    // this.accountService.listBySearch(params).subscribe(
    //   res => {
    //     this.lstAccountDto = res.items ?? [];
    //   },
    //   () => {
    //   },
    //   () => {
    //   }
    // );

    // // lstCustomer.
    // this.customerService.listBySearch(params).subscribe(
    //   res => {
    //     this.lstCustomerDto = res.items ?? [];
    //   },
    //   () => {
    //   },
    //   () => {
    //   }
    // );

    this.getList();
    this.isLoading = false;
  }

  getList() {
    this.isLoading = true;
    let params = CommonUtil.removeEmptyValues(this.params);
    this.orderService.listBySearch(params).subscribe(
      res => {
        this.list = res.items ?? [];
        this.list.forEach((item, index) => {
          item.index1 = this.query.page * this.query.size + index + 1
          item.sourceName = this.lstOrderSourceDto.find(item1 => item1.value === item.source)?.name;
          item.statusName = this.lstOrderStatusDto.find(item1 => item1.value === item.status)?.name;
          item.buyerName = item.buyer?.fullName + ' - ' + item.buyer?.phoneNumber;
          item.receiverName = item.receiver?.fullName + ' - ' + item.receiver?.phoneNumber;
          // item.price = this.decimalPipe.transform(item.price, '2', 'vi-VN')?? 0;
          item.deliveryDateTime = this.datePipe.transform(item.deliveryDateTime, this.settings.getLanguage() === 'vi-VN' ? 'dd/MM/yyyy HH:mm:ss' : 'MM/dd/yyyy HH:mm:ss') ?? '';

          return item;
        })
        this.total = res.totalItems ?? 0;
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

    this.statistic();
  }

  statistic() {
    this.isLoading = true;
    this.reportService.statistic().subscribe(
      res => {
        // Set status number for all.
        let statusAllQuantity = 0;
        this.lstOrderStatusStatisticResDto = res.data ?? [];
        this.lstOrderStatusStatisticResDto.forEach(item => {
          let status = this.lstOrderStatusDto.find(item1 => item1.value === item.status);
          if (status) {
            status.quantity = item.numberOfOrder ?? 0;
            if (this.roles.indexOf('ADMINISTRATOR_PRIVILEGE') > -1 || this.roles.indexOf('SALE_PRIVILEGE') > -1) {
            }

            // todo statistic.
            if (this.roles.indexOf('FLORIST_PRIVILEGE') > -1) {
              let statusName = '' + status?.value;
              if (['NEW', 'DOING', 'DONE', 'CUSTOMER_SATISFIED', 'ERROR', 'FINISHED'].indexOf(statusName) < 0) {
                status.quantity = 0;
              }
            }
            else if (this.roles.indexOf('SHIPPER_PRIVILEGE') > -1) {
              let statusName = '' + status?.value;
              if (['DONE', 'SHIPPING', 'CUSTOMER_SATISFIED', 'ERROR', 'FINISHED'].indexOf(statusName) < 0) {
                status.quantity = 0;
              }
            }
          }
          // total status.
          statusAllQuantity += status?.quantity ?? 0;
        });
        let statusAll = this.lstOrderStatusDto.find(item1 => item1.value === '');
        if (statusAll) {
          statusAll.quantity = statusAllQuantity;
        }

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
  }

  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageChanged(event?: PageEvent) {
    // console.log(event);
    this.query.page = event?.pageIndex ?? 0;
    this.query.size = event?.pageSize ?? 0;
    this.getList();
  }

  // MatPaginator Output
  pageEvent!: PageEvent;

  search() {
    let orderStatus = this.searchForm.controls['status'].value;
    this.selectedTabIndex = this.tabs.findIndex(item => item.value === orderStatus);

    this.query.page = 0;
    this.getList();
  }

  reset() {
    this.searchForm.controls['code'].setValue('');
    this.searchForm.controls['status'].setValue('');
    this.searchForm.controls['buyerPhoneNumber'].setValue('');
    this.searchForm.controls['receiverPhoneNumber'].setValue('');
    this.searchForm.controls['createdSaleId'].setValue('');
    this.searchForm.controls['supportedSaleId'].setValue('');
    this.searchForm.controls['deliveryFromDateTime'].setValue(null);
    this.searchForm.controls['deliveryToDateTime'].setValue(null);

    this.selectedTabIndex = 0;

    this.query = { ...this.defaultQuery };
    this.getList();
  }

  edit(value: any) {
    let getByIdObservable = of({});
    // Edit.
    if (value && value.id) {
      getByIdObservable = this.orderService.findById(value.id);
    }
    getByIdObservable.subscribe(
      (orderResDto: OrderResDto) => {
        const dialogRef = this.dialog.originalOpen(OrderEditComponent, {
          height: 'auto',
          maxHeight: '90vh',
          width: '60vw',
          data: orderResDto,
        });

        dialogRef.afterClosed().subscribe(() => {
          // console.log('The dialog was closed');
          this.getList();
        });
      }
    );
  }

  payment(orderResDto: OrderResDto) {
    const dialogRef = this.dialog.originalOpen(OrderPaymentComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '60vw',
      data: orderResDto,
    });

    dialogRef.afterClosed().subscribe(() => {
      this.query.page = 0;
      this.getList();
    });
  }

  // Preview images
  preview(orderResDto: OrderResDto) {
    let index = 1;
    const dialogRef = this.dialog.originalOpen(ImageEditComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '60vw',
      data: orderResDto,
    });

    dialogRef.afterClosed().subscribe(() => {
      this.query.page = 0;
      this.getList();
    });
  }

  assign(orderResDto: OrderResDto) {
    const dialogRef = this.dialog.originalOpen(OrderAssignComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '60vw',
      data: orderResDto,
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      this.getList();
    });
  }

  updateStatus(orderResDto: OrderResDto) {
    const dialogRef = this.dialog.originalOpen(OrderStatusComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '60vw',
      data: orderResDto,
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      this.getList();
    });
  }

  comment(orderResDto: OrderResDto) {
    const dialogRef = this.dialog.originalOpen(OrderCommentComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '60vw',
      data: orderResDto,
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      this.getList();
    });
  }

  delete(id: string) {
    const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: null,
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.orderService.delete(id).subscribe(
          (response) => {
            // this.dialog.alert(`You have deleted ${value.code}!`);
            this.getList();
          },
          (error) => {

          }
        )
      }
    });
  }

  changeSelect(event: any) {
    // console.log(event);
  }

  changeSort(event: any) {
    console.log(event);
    this.query.sortBy = event.active;
    this.query.ascDirection = event.direction === 'desc' ? '0' : '1';
  }

  enableRowExpandable() {
    this.columns[0].showExpand = this.expandable;
  }

  updateCell() {
    this.list = this.list.map(item => {
      // item.weight = Math.round(Math.random() * 1000) / 100;
      return item;
    });
  }

  updateList() {
    this.list = this.list.splice(-1).concat(this.list);
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }
}
