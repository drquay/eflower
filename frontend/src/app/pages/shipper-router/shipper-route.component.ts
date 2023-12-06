import { DatePipe, DecimalPipe, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, LOCALE_ID, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MAT_MOMENT_DATE_ADAPTER_OPTIONS, MAT_MOMENT_DATE_FORMATS, MomentDateAdapter } from '@angular/material-moment-adapter';
import { DateAdapter, MAT_DATE_FORMATS, MAT_DATE_LOCALE } from '@angular/material/core';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { CommonUtil } from '@shared/utils/common-util';
import { AccountDto } from 'app/dto/account.dto';
import { ShipperRouteRes } from 'app/dto/shipper-route.res';
import { AccountService } from 'app/services/account.service';
import { ShipperRouteService } from 'app/services/shipper-route.service';
import * as moment from 'moment';
import { Subscription } from 'rxjs';
import { BeginOrEndRouteComponent } from './begin-or-end/begin-or-end-route.component';
import { ShipperRouteEditComponent } from './edit/shipper-route-edit.component';


@Component({
  selector: 'page-shipper-route',
  templateUrl: './shipper-route.component.html',
  styleUrls: ['./shipper-route.component.scss'],
  providers: [
    ShipperRouteService,
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
export class ShipperRouteComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  searchForm: FormGroup;

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
      header: 'Mã shipper',
      field: 'shipperName',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: 'Số km',
      field: 'numberOfKm',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: 'Tọa độ x bắt đầu',
      field: 'beginLongitude',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: 'Tọa độ y bắt đầu',
      field: 'beginLatitude',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: 'Tọa độ x kết thúc',
      field: 'endLongitude',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: 'Tọa độ y kết thúc',
      field: 'endLatitude',
      sortable: true,
      disabled: false,
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
          color: 'warn',
          icon: 'delete',
          text: this.translate.stream('common.delete'),
          tooltip: this.translate.stream('common.delete'),
          click: record => this.delete(record.id),
        },
      ],
    },
  ];
  list: ShipperRouteRes[] = [];
  total = 0;
  isLoading = true;

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
    size: 10,
    accountId: '',
    fromDate: '',
    toDate: '',
    sortBy: 'createdOn',
    ascDirection: '0',
  };
  query = { ...this.defaultQuery };

  get params() {
    this.query.fromDate = this.datePipe.transform(this.searchForm.controls['fromDate'].value, 'yyyy-MM-dd') ?? '';
    this.query.toDate = this.datePipe.transform(this.searchForm.controls['toDate'].value, 'yyyy-MM-dd') ?? '';

    const params = Object.assign({}, this.query);
    // params.page += 1;
    return params;
  }

  unsort(a: any, b: any) {
    return 1;
  }

  public currentDate?: moment.Moment = moment();
  @ViewChild('picker') picker: any;
  public minDate?: moment.Moment;
  public maxDate?: moment.Moment;

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

    private accountService: AccountService,
    private shipperRouteService: ShipperRouteService,
  ) {
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
      fromDate: [null],
      toDate: [null],
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
       },
       () => {
       },
       () => {
       }
     );
 
     // this.getList();
     this.isLoading = false;
   }

   isError() : boolean {
     let isError = 
     this.searchForm.get('fromDate')?.hasError('required')
     || this.searchForm.get('toDate')?.hasError('required')
     ;
 
     return isError ?? true;
   }

  getList() {
    this.searchForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }
    this.isLoading = true;
    let params = CommonUtil.removeEmptyValues(this.params);

    this.shipperRouteService.listBySearch(params).subscribe(
      res => {
        this.list = res.items ?? [];
        this.list.forEach((item, index) => {
          item.index1 = this.query.page * this.query.size + index + 1;
          item.shipperName = this.lstAccountDto.find(item1 => item1.id === item.shipperId)?.fullName;
        });
        
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
  }


  // MatPaginator Output
  // pageEvent!: PageEvent;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageChanged(event?: PageEvent) {
    // console.log(event);
    this.query.page = event?.pageIndex ?? 0;
    this.query.size = event?.pageSize ?? 0;
    this.getList();
  }

  search() {
    this.query.page = 0;
    this.getList();
  }

  reset() {
    this.query = { ...this.defaultQuery };
    this.getList();
  }

  beginOrEndRoute() {
    const dialogRef = this.dialog.originalOpen(BeginOrEndRouteComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '50vw',
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      this.getList();
    });
  }

  edit(value: any) {
    const dialogRef = this.dialog.originalOpen(ShipperRouteEditComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: '50vw',
      data: value,
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
        this.shipperRouteService.delete(id).subscribe(
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
    this.list = this.list.map(item => {
      // item.weight = Math.round(Math.random() * 1000) / 100;
      return item;
    });
  }

  updateList() {
    this.list = this.list.splice(-1).concat(this.list);
  }
}
