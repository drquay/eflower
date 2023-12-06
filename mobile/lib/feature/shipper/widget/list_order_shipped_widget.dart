import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/history/widget/history_page.dart';
import 'package:flutter_boilerplate/feature/shipper/widget/shipper_home.dart';
import 'package:flutter_boilerplate/l10n/l10n.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:flutter_boilerplate/shared/util/image_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ListOrderShipped extends ConsumerWidget {
  const ListOrderShipped({Key? key}) : super(key: key);
  static final listStatusDone=[OrderStatus.SHIPPED_WITH_NONPAYMENT.name,OrderStatus.SHIPPED_WITH_PAYMENT.name,OrderStatus.FINISHED.name];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ordersProviderSHIPPER;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Danh sách các hàng đã giao'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await ref.read(provider.notifier).fetchOrders();
            },
            child: _widgetContent(context, ref, provider)),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _widgetShimmer(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref, dynamic provider) {
    final state = ref.watch(provider);

    return state.when(
      loading: () {
        return _widgetShimmer(context, ref);
      },
      ordersLoaded: (OrderResponse orders) {
        final items = orders.items.where((element) => listStatusDone.contains(element.status)).whereType<Order>().toList();
        if (items.isEmpty) {
          return Center(child: Text('Chưa có đơn hàng nào'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderShippedListRow(
                order: items[index], index: index);
          },
        );
      },
      error: (AppException error) {
        return _widgetShimmer(context, ref);
      },
    );
  }
}

class OrderShippedListRow extends StatelessWidget {
  const OrderShippedListRow(
      {Key? key, required this.order, required this.index})
      : super(key: key);

  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => {
          Get.to(() => HistoryPage(order.id))
      },
      child: Card(
        key: ValueKey(order.id),
        color: Colors.white,
        elevation: 8,
        margin: EdgeInsets.symmetric(vertical: 2.w),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.w),
          child: ListTile(
            leading: Semantics(
              child:
                  Container(width: 65, height: 65, decoration: _leadingImage()),
            ),
            title: _title(),
            isThreeLine: true,
            subtitle: Column(
              children: [
                SizedBox(height: 2.w),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.red, size: 25),
                          const SizedBox(width: 6),
                          Text(order.source),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        children: [
                          const Icon(Icons.phone_enabled,
                              color: Colors.red, size: 25),
                          const SizedBox(width: 6),
                          Text(order.buyer.phoneNumber ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3.w),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_outlined,
                              color: Colors.red, size: 25),
                          const SizedBox(width: 6),
                          Text(order.deliveryDateTime),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle_outlined,
                              color: Colors.red, size: 25),
                          const SizedBox(width: 6),
                          Text(order.createdBy ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            dense: true,
          ),
        ),
      ),
    );
  }

  BoxDecoration _leadingImage() {
    if (order.attachments == null || order.attachments!.isEmpty) {
      return BoxDecoration(
        image: DecorationImage(
          image: ImageUtil.defaultImage(),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      );
    }

    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(order.attachments![0].url),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _title() {
    return Text('KH:${order.buyer.fullName}');
  }
}
