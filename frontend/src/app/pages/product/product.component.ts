import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { MatPaginatorIntl, PageEvent } from '@angular/material/paginator';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { MtxGridColumn } from '@ng-matero/extensions/grid';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { CommonUtil } from '@shared/utils/common-util';
import { ProductReqDto } from 'app/dto/product-req.dto';
import { ProductService } from 'app/services/product.service';
import { ProductEditComponent } from './edit/product-edit.component';


@Component({
  selector: 'page-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.scss'],
  providers: [ProductService],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProductComponent implements OnInit {
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
      header: 'Mã sản phẩm',
      field: 'code',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: 'Tên sản phẩm',
      field: 'name',
      sortable: true,
      disabled: true,
      minWidth: 100,
    },
    {
      header: 'Mô tả',
      field: 'description',
      sortable: true,
      disabled: false,
      minWidth: 100,
    },
    {
      header: 'Đường dẫn tham khảo',
      field: 'referenceUrl',
      type: 'link',
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
  list: ProductReqDto[] = [];
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
    private productService: ProductService,
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
        case 'code': {
          params.code = this.params.search;
          break;
        }
      }
    }
    delete params['by'];

    this.productService.listBySearch(params).subscribe(
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

  edit(value: any) {
    const dialogRef = this.dialog.originalOpen(ProductEditComponent, {
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
        this.productService.delete(id).subscribe(
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
