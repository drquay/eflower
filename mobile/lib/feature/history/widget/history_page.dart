import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/history/widget/create_history_widget.dart';
import 'package:flutter_boilerplate/feature/history/widget/update_history_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/payment_history_provider.dart';
import 'package:flutter_boilerplate/shared/model/payment_history.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPage extends ConsumerWidget {
  HistoryPage(this.orderId, {Key? key}) : super(key: key);

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentHistoryProvider);

    return state.when(initial: () {
      ref
          .read(paymentHistoryProvider.notifier)
          .retrieveListPaymentHistory(orderId: orderId);

      return _widgetShimmer(context, ref);
    }, empty: () {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Lịch sử thanh toán'),
          ),
          body: const Center(child: Text('Lịch sử trống')));
    }, hasValue: (data) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Lịch sử thanh toán'),
        ),
        backgroundColor: Color(0xFFF4F4F4),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, right: 16, left: 16, bottom: 25),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                child: Text(
                                  'Tạo yêu cầu giữ tiền',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => CreateHistoryWidget(orderId));
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _historyWidget(data[index], ref);
                  }),
            ),
          ],
        ),
      );
    });
  }

  Widget _widgetShimmer(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _historyWidget(PaymentHistory history, WidgetRef ref) {
    bool editAble=false;
    ref.watch(tokenProvider).maybeWhen(
        orElse: () {},
        hasValue: (token) {
          editAble =
              history.createdBy != null && history.createdBy == token.username;
        });

    return Container(
//      height: 100.0,
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0),
                    //   child: Image.asset(
                    //     history.historyAssetPath,
                    //     height: 40.0,
                    //     width: 40.0,
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              history.type,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 8),
                            Text(history.moneyKeeper.fullName ?? '')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${NumberFormat('###,###').format(history.amount)} đ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${history.createdOn}',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text('Note: ${history.note ?? ''}'))
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text('Lý do: ${history.paymentReason}'))
                  ],
                ),
                // if (editAble)
                //   Align(
                //       alignment: Alignment.topRight,
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.edit,
                //         ),
                //         onPressed: () {
                //           Get.to(()=>UpdateHistoryWidget(orderId, history));
                //         },
                //       )),
              ],
            )),
      ),
    );
  }
}
