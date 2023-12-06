import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/feature/florist/provider/orders_provider.dart';
import 'package:flutter_boilerplate/feature/florist/state/orders_state.dart';
import 'package:flutter_boilerplate/feature/florist/widget/row_order_widget.dart';
import 'package:flutter_boilerplate/feature/notification/provider/notify_provider.dart';
import 'package:flutter_boilerplate/feature/notification/widget/notification_drawer.dart';
import 'package:flutter_boilerplate/feature/report/provider/order_statistic_provider.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final ordersProviderNEW =
StateNotifierProvider<OrdersProvider, OrdersState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OrdersProvider(ref.read, appStartState, [OrderStatus.NEW.name]);
});
final ordersProviderDOING =
StateNotifierProvider<OrdersProvider, OrdersState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OrdersProvider(ref.read, appStartState, [OrderStatus.DOING.name]);
});

final ordersProviderREJECTED =
StateNotifierProvider<OrdersProvider, OrdersState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OrdersProvider(ref.read, appStartState,
      [OrderStatus.CUSTOMER_REJECTED.name,OrderStatus.SALE_REJECTED.name]);
});

class FloristHome extends ConsumerWidget {
  FloristHome({Key? key}) : super(key: key);
  String? _accountId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var numberOfNewOrder = 0;
    var numberOfDoingOrder = 0;
    var numberOfErrorRejected = 0;
    var numberOfNotifications = 0;
    ref.watch(notifyProvider).whenOrNull(hasNotifications: (notifications){
      numberOfNotifications = notifications.length;
    });
    ref.watch(tokenProvider).maybeWhen(orElse: (){},hasValue: (token){_accountId = token.id;});
    ref.watch(ordersProviderNEW).maybeWhen(
        ordersLoaded: (orders) {
          numberOfNewOrder = orders.totalItems;
        },
        orElse: () {});
    ref.watch(ordersProviderDOING).maybeWhen(
        ordersLoaded: (orders) {
          numberOfDoingOrder = orders.totalItems;
        },
        orElse: () {});

    ref.watch(ordersProviderREJECTED).maybeWhen(
        ordersLoaded: (orders) {
          numberOfErrorRejected = orders.totalItems;
        },
        orElse: () {});

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NotificationDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.read(orderStatisticProvider.notifier).orderStatistic();
            await ref.read(ordersProviderNEW.notifier).fetchOrders();
            await ref.read(ordersProviderDOING.notifier).fetchOrders();
            await ref.read(ordersProviderREJECTED.notifier).fetchOrders();
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    tabs: [
                      _tab('Đơn mới', numberOfNewOrder),
                      _tab('Đơn đang làm', numberOfDoingOrder),
                      _tab('Đơn lỗi', numberOfErrorRejected)
                    ],
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.blueGrey,
                  title: Text(context.l10n.florist_title),
                  actions:[
                    Stack(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.notifications_outlined), // Custom icon for the drawer
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        if (numberOfNotifications > 0)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '$numberOfNotifications',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    )],
                ),
              ];
            },
            body: TabBarView(
              children: [
                _widgetContent(
                    context, ref,  ordersProviderNEW),
                _widgetContent(context, ref,
                    ordersProviderDOING),
                _widgetContent(
                    context,
                    ref,
                    ordersProviderREJECTED),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _widgetShimmer(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _tab(String name, int numberOrders) {
    return Tab(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: name,
          children: [
            TextSpan(
              text: ' ($numberOrders)',
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref, dynamic provider) {
    final state = ref.watch(provider);

    return state.when(
      loading: () {
        return _widgetShimmer(context, ref);
      },
      ordersLoaded: (OrderResponse orders) {
        orders.items.sort((a, b) => a.deliveryDateTime.compareTo(b.deliveryDateTime));
        if (orders.items.isEmpty) {
          return Center(child: Text('Chưa có đơn hàng nào'));
        }

        return ListView.builder(
          itemCount: orders.items.length,
          itemBuilder: (BuildContext context, int index) {
            return RowOrderWidget(order: orders.items[index], index: index,accountId: _accountId??'');
          },
        );
      },
      error: (AppException error) {
        return _widgetShimmer(context, ref);
      },
    );
  }
}
