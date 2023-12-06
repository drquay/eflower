import { Component, Input, ViewEncapsulation } from '@angular/core';
import { Menu, MenuService } from '@core';
import { UserService } from '@core/authentication/user.service';
import { filter, map } from 'rxjs/operators';

@Component({
  selector: 'app-sidemenu',
  templateUrl: './sidemenu.component.html',
  styleUrls: ['./sidemenu.component.scss'],
  encapsulation: ViewEncapsulation.None,
})
export class SidemenuComponent {
  // NOTE: Ripple effect make page flashing on mobile
  @Input() ripple = false;

  menu$ = this.menu.getAll().pipe(
    map((items: Menu[]) => {
      let routes: string[] = ['home'];
      let roles: string[] = this.userService.get().roles;
      console.log(roles);
      if (roles.indexOf('ADMINISTRATOR_PRIVILEGE') > -1) {
        routes.push('account');
        routes.push('customer');
        routes.push('product');
        routes.push('order');
        routes.push('shipper-route');
        routes.push('report');
      } else
      if (roles.indexOf('SALE_ADMIN_PRIVILEGE') > -1) {
        routes.push('customer');
        routes.push('product');
        routes.push('order');
        routes.push('shipper-route');
        routes.push('report');
      } else
      if (roles.indexOf('PROVINCIAL_ORDER_MANAGER_PRIVILEGE') > -1) {
        routes.push('customer');
        routes.push('product');
        routes.push('order');
      } else
      if (roles.indexOf('SALE_PRIVILEGE') > -1) {
        routes.push('customer');
        routes.push('product');
        routes.push('shipper-route');
        routes.push('order');
      } else
      if (roles.indexOf('DISPATCHERS_PRIVILEGE') > -1) {
        routes.push('order');
      } else
      if (roles.indexOf('FLORIST_PRIVILEGE') > -1) {
        routes.push('order');
        // routes.push('florist');
        // Change menu label.
        let florist = items.filter(item => item.route == 'florist');
        if (florist && florist.length > 0) {
          florist[0].name = 'menu.order.florist';
        }
      } else
      if (roles.indexOf('SHIPPER_PRIVILEGE') > -1) {
        routes.push('order');
        // routes.push('shipper');
        // Change menu label.
        let florist = items.filter(item => item.route == 'shipper');
        if (florist && florist.length > 0) {
          florist[0].name = 'menu.order.shipper';
        }
      }

      return items.filter(item => {
        return routes.indexOf(item.route) > -1;
      });
    }
    ),
    filter(items =>
      items && items.length > 0
    )
  );;
  buildRoute = this.menu.buildRoute;

  constructor(private menu: MenuService, private userService: UserService) { }
}
