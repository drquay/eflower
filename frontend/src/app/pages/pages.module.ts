import { NgModule } from '@angular/core';
import { SharedModule } from '@shared/shared.module';
import { PagesRoutingModule } from './pages-routing.module';
import {ScrollingModule} from '@angular/cdk/scrolling';

import { DashboardComponent } from './dashboard/dashboard.component';
import { LoginComponent } from './sessions/login/login.component';
import { RegisterComponent } from './sessions/register/register.component';
import { Error403Component } from './sessions/403.component';
import { Error404Component } from './sessions/404.component';
import { Error500Component } from './sessions/500.component';

import { CustomerComponent } from './customer/customer.component';
import { CustomerEditComponent } from './customer/edit/customer-edit.component';
import { OrderEditComponent } from './order/edit/order-edit.component';
import { OrderComponent } from './order/order.component';
import { LocalizedNumericInputDirective } from '@shared/directives/ef-localized-numberirc-input.directive';
import { ImageViewerComponent } from './order/image/image-viewer.component';
import { OrderAssignComponent } from './order/assign/order-assign.component';
import { OrderStatusComponent } from './order/status/order-status.component';
import { ImageEditComponent } from './order/image/image-edit.component';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { HomeComponent } from './home/home.component';
import { ReportComponent } from './report/report.component';
import { AccountComponent } from './account/account.component';
import { AccountEditComponent } from './account/edit/account-edit.component';
import { ChangePasswordComponent } from './account/change-password/change-password.component';
import { ProductComponent } from './product/product.component';
import { ProductEditComponent } from './product/edit/product-edit.component';
import { OrderPaymentComponent } from './order/payment/payment.component';
import { OrderCommentComponent } from './order/comment/comment.component';
import { ShipperRouteComponent } from './shipper-router/shipper-route.component';
import { ShipperRouteEditComponent } from './shipper-router/edit/shipper-route-edit.component';
import { BeginOrEndRouteComponent } from './shipper-router/begin-or-end/begin-or-end-route.component';

const COMPONENTS: any[] = [
  DashboardComponent,
  LoginComponent,
  RegisterComponent,
  Error403Component,
  Error404Component,
  Error500Component,
];
const COMPONENTS_DYNAMIC: any[] = [
  ConfirmDialogComponent,
  HomeComponent,
  AccountComponent,
  AccountEditComponent,
  ChangePasswordComponent,
  CustomerComponent,
  CustomerEditComponent,
  ProductComponent,
  ProductEditComponent,
  OrderComponent,
  OrderEditComponent,
  OrderPaymentComponent,
  ImageViewerComponent,
  ImageEditComponent,
  OrderAssignComponent,
  OrderStatusComponent,
  OrderCommentComponent,
  ShipperRouteComponent,
  BeginOrEndRouteComponent,
  ShipperRouteEditComponent,
  ReportComponent,
];

@NgModule({
  imports: [SharedModule, PagesRoutingModule, ScrollingModule],
  declarations: [...COMPONENTS, ...COMPONENTS_DYNAMIC,
    LocalizedNumericInputDirective,
  ],
})
export class PagesModule {}
