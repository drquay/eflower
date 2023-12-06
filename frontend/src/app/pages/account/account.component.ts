import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { CommonUtil } from '@shared/utils/common-util';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AccountDto } from 'app/dto/account.dto';
import { AccountService } from 'app/services/account.service';
import { ChangePasswordComponent } from './change-password/change-password.component';
import { AccountEditComponent } from './edit/account-edit.component';


@Component({
  selector: 'page-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.scss'],
  providers: [AccountService],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AccountComponent implements OnInit {
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
      header: this.translate.stream('pages.account.username'),
      field: 'username',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: this.translate.stream('pages.account.fullName'),
      field: 'fullName',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: this.translate.stream('pages.account.phoneNumber'),
      field: 'phoneNumber',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: this.translate.stream('common.operation'),
      field: 'operation',
      minWidth: 120,
      width: 'auto',
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
          icon: 'vpn_key',
          tooltip: this.translate.stream('user.changePassword'),
          click: record => this.changePassword(record),
        },
        {
          type: 'icon',
          icon: 'block',
          tooltip: 'Cấm truy cập',
          click: record => this.blockAccount(record),
        },
        {
          type: 'icon',
          icon: 'verified_user',
          tooltip: 'Cho phép truy cập',
          click: record => this.unblockAccount(record),
        },
      ],
    },
  ];
  list: AccountDto[] = [];
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
  query = { ...this.defaultQuery };

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
    private accountService: AccountService,
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
        case 'username': {
          params.username = this.params.search;
          break;
        }
      }
    }
    delete params['by'];

    this.accountService.listBySearch(params).subscribe(
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
    this.query = { ...this.defaultQuery };
    this.getList();
  }

  edit(value: AccountResDto) {
    const dialogRef = this.dialog.originalOpen(AccountEditComponent, {
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

  changePassword(value: AccountResDto) {
    const dialogRef = this.dialog.originalOpen(ChangePasswordComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: value,
    });

    dialogRef.afterClosed().subscribe(() => {
      // console.log('The dialog was closed');
      this.getList();
    });
  }

  blockAccount(accountResDto: AccountResDto) {
    const data = {
      title: 'Cho phép truy cập?',
      message: `${accountResDto.fullName}`,
      confirmButtonText: 'Đồng ý',
      cancelButtonText: 'Đóng',
    }
    const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: data,
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.accountService.blockAccount(accountResDto.id ?? '').subscribe(
          (response: any) => {
            this.cdr.detectChanges();
          },
          (error: any) => {

          }
        );
      }
    });
  }

  unblockAccount(accountResDto: AccountResDto) {
    const data = {
      title: 'Cấm truy cập?',
      message: `${accountResDto.fullName}`,
      confirmButtonText: 'Đồng ý',
      cancelButtonText: 'Đóng',
    }
    const dialogRef = this.dialog.originalOpen(ConfirmDialogComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: data,
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.accountService.unblockAccount(accountResDto.id ?? '').subscribe(
          (response: any) => {
            this.cdr.detectChanges();
          },
          (error: any) => {

          }
        );
      }
    });
  }

  delete(value: AccountDto) {
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
