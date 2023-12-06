import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/payment_history_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/model/payment_history.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/provider/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';

class UpdateHistoryWidget extends ConsumerWidget {
  UpdateHistoryWidget(this.orderId, this.paymentHistory, {Key? key}) : super(key: key);
  final String orderId;
  final PaymentHistory paymentHistory;
  late  final _amountController = TextEditingController(text: paymentHistory.amount.toString());
  late final _moneyKeeperController = TextEditingController(text: paymentHistory.moneyKeeper.fullName);
  late final _noteController = TextEditingController(text: paymentHistory.note);
  late final _typeController =
  TextEditingController(text: paymentHistory.type);
  String _moneyKeeper = '';
  List<User> _listAccount = List.empty();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAccount = ref.read(accountProvider.notifier).getListAccount();
    void _show(BuildContext ctx) {
      showCupertinoModalPopup(
          context: ctx,
          builder: (_) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () {
                    _typeController.text = PaymentTypeEnum.CASH.name;
                  },
                  child: Text(PaymentTypeEnum.CASH.name)),
              CupertinoActionSheetAction(
                  onPressed: () {
                    _typeController.text = PaymentTypeEnum.MOMO.name;
                  },
                  child: Text(PaymentTypeEnum.MOMO.name)),
              CupertinoActionSheetAction(
                  onPressed: () {
                    _typeController.text =
                        PaymentTypeEnum.BANK_TRANSFER.name;
                  },
                  child: Text(PaymentTypeEnum.BANK_TRANSFER.name)),
              CupertinoActionSheetAction(
                  onPressed: () {
                    _typeController.text = PaymentTypeEnum.OTHER.name;
                  },
                  child: Text(PaymentTypeEnum.OTHER.name)),
            ],
          ));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Tạo yêu cầu chuyển tiền'),
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: FutureBuilder<UserResponse?>(
                future: listAccount,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    _listAccount = snapshot.data!.items;
                  }

                  return Column(
                    children: <Widget>[
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Số tiền',
                                  errorText:
                                  requiredField(_amountController.text)),
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onEditingComplete: () {
                                final formatter = NumberFormat('###,###');
                                _amountController.text = formatter
                                    .format(
                                    double.parse(_amountController.text))
                                    .toString();
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Chọn người giữ tiền',
                                        errorText: requiredField(
                                            _moneyKeeperController.text)),
                                    controller: _moneyKeeperController,
                                    readOnly: true,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _showChooseMoneyKeeper(context);
                                    },
                                    icon: Icon(Icons.add))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Chọn phương thức',
                                        errorText: requiredField(
                                            _typeController.text)),
                                    controller: _typeController,
                                    readOnly: true,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _show(context);
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Ghi chú',
                              ),
                              controller: _noteController,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GFButton(
                                  onPressed: () async {
                                    await ref
                                        .read(paymentHistoryProvider.notifier)
                                        .performUpdatePaymentHistory(
                                        orderId: orderId,
                                        paymentId: paymentHistory.id,
                                        amount: double.parse(
                                            _amountController.text),
                                        moneyKeeperId:
                                        _moneyKeeper,
                                        type: _typeController.text,
                                        note: _noteController.text);
                                    Get.back();

                                  },
                                  text: 'Cập nhật',
                                  elevation: 4,
                                ))
                          ],
                        ),
                      )
                    ],
                  );
                })));
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _showChooseMoneyKeeper(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
          actions: [
            if (_listAccount != null)
              Container(
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  itemCount: _listAccount.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CupertinoActionSheetAction(
                        onPressed: () {
                          _moneyKeeperController.text =
                              _listAccount[index].fullName ?? '';
                          _moneyKeeper= _listAccount[index].id??'';
                        },
                        child: Text(_listAccount[index].fullName ?? ''));
                  },
                ),
              )
          ],
        ));
  }

  String? requiredField(String value) {
    if (value.isEmpty) {
      return 'Thông tin bắt buộc';
    }
    return null;
  }
}
