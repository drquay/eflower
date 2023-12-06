import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/florist/provider/orders_provider.dart';
import 'package:flutter_boilerplate/feature/florist/state/orders_state.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/order_to_ship_list_row_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_track_status_widget.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/provider/token_provider.dart';
import '../provider/shipper_route_provider.dart';


final ordersProviderSHIPPER =
StateNotifierProvider<OrdersProvider, OrdersState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OrdersProvider(
      ref.read, appStartState, []);
});

class ShipperHome extends ConsumerWidget {
  const ShipperHome({Key? key}) : super(key: key);
  static final listStatusDone=[OrderStatus.SHIPPED_WITH_NONPAYMENT.name,OrderStatus.SHIPPED_WITH_PAYMENT.name,OrderStatus.FINISHED.name];
  static String userId='';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var numberOfShippingOrder = 0;
    var numberOfShippedOrder = 0;
    ref.watch(tokenProvider).maybeWhen(
        hasValue: (token) {
          userId = token.id;
        },
        orElse: () {});
    ref.watch(ordersProviderSHIPPER).maybeWhen(
        ordersLoaded: (OrderResponse orderResponse) {
          numberOfShippedOrder=0;
          ref
              .read(shipperRouteProvider.notifier)
              .findShipperRouteByShipperId(shipperId: userId);
          for(final  order in orderResponse.items){
            if(listStatusDone.contains(order.status)){
              numberOfShippedOrder+=1;
            }
            else{
              numberOfShippingOrder+=1;
            }
          }
        },
        orElse: () {});

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
             await ref.read(ordersProviderSHIPPER.notifier).fetchOrders();

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
                      _tab('Đang giao', numberOfShippingOrder),
                      _tab('Đã giao', numberOfShippedOrder),
                    ],
                  ),
                  backgroundColor: Colors.blueGrey,
                  title: Text(context.l10n.florist_title),
                  actions: [
                    ShipperTrackStatusWidget(numberOfShippingOrder!=0)
                  ],
                ),
              ];
            },
            body: TabBarView(
              children: [
                _widgetContent(context, ref,[OrderStatus.SHIPPING.name],
                    ordersProviderSHIPPER,),
                _widgetContent(context, ref,listStatusDone,
                    ordersProviderSHIPPER),
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

  Widget _widgetContent(BuildContext context, WidgetRef ref,List<String> statuses, dynamic provider) {
    final state = ref.watch(provider);

    return state.when(
      loading: () {
        return _widgetShimmer(context, ref);
      },
      ordersLoaded: (OrderResponse orders) {
        orders.items.sort((a, b) => a.deliveryDateTime.compareTo(b.deliveryDateTime));
        final items = orders.items.where((element) => statuses.contains(element.status)).whereType<Order>().toList();

        if (items.isEmpty) {
          return Center(child: Text('Chưa có đơn hàng nào'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderToShipListRow(order: items[index], index: index);
          },
        );
      },
      error: (AppException error) {
        return _widgetShimmer(context, ref);
      },
    );
  }
}
