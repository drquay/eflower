import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { CommonUtil } from '@shared/utils/common-util';
import { CustomerDto } from 'app/dto/customer.dto';
import { CustomerService } from 'app/services/customer.service';
import { CustomerEditComponent } from './edit/customer-edit.component';


@Component({
  selector: 'page-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.scss'],
  providers: [CustomerService],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CustomerComponent implements OnInit {
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
      header: this.translate.stream('pages.customer.fullName'),
      field: 'fullName',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: this.translate.stream('pages.customer.phoneNumber'),
      field: 'phoneNumber',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: this.translate.stream('pages.customer.address'),
      field: 'address',
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
      ],
    },
  ];
  list: CustomerDto[] = [];
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
    private translate: TranslateService,
    public dialog: MtxDialog,
    private cdr: ChangeDetectorRef,
    public _MatPaginatorIntl: MatPaginatorIntl,
    private customerService: CustomerService,
  ) { }

  ngOnInit() {
    this._MatPaginatorIntl.itemsPerPageLabel = 'Số dòng trên trang';

    this.getList();
    this.isLoading = false;
  }

  getList() {
    this.isLoading = true;
    let params = CommonUtil.removeEmptyValues(this.params);
    if (this.params.search) {
      switch (this.query.by) {
        case 'name': {
          params.name = this.params.search;
          break;
        }
        case 'phone': {
          params.phone = this.params.search;
          break;
        }
        case 'address': {
          params.address = this.params.search;
          break;
        }
      }
    }
    delete params['by'];

    this.customerService.listBySearch(params).subscribe(
      res => {
        this.list = res.items ?? [];
        this.list.forEach((item, index) => item.index1 = this.query.page * this.query.size + index + 1);
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
    this.query = {...this.defaultQuery};
    this.getList();
  }

  edit(value: any) {
    const dialogRef = this.dialog.originalOpen(CustomerEditComponent, {
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

  delete(value: CustomerDto) {
    this.dialog.alert(`You have deleted ${value.fullName}!`);
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
