import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/order_status_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class RequestChangeMoneyKeeperButton extends ConsumerWidget {
  RequestChangeMoneyKeeperButton(
      {Key? key,
      required this.orderId,
      required this.currentStatus,
      required this.version,
      this.assignedId,
      this.files,
      this.width,
      this.icon,
      this.textStyle,
      this.padding,
      this.onPressed})
      : super(key: key);

  final String orderId;
  final String currentStatus;
  final int version;
  String? assignedId;
  List<XFile>? files;
  double? width;
  Icon? icon;
  TextStyle? textStyle;
  EdgeInsetsGeometry? padding;
  VoidCallback? onPressed;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatusUtil.mappingBtnActionFlorist(currentStatus);
    final isEnable = ![
      OrderStatus.ERROR.name,
      OrderStatus.SHIPPED_WITH_NONPAYMENT.name,
      OrderStatus.FINISHED.name
    ].contains(currentStatus);

    return Center(
      child: Container(
        width: width ?? 60.w,
        padding: padding ?? EdgeInsets.only(bottom: 10.w),
        child: GFButton(
          onPressed: isEnable
              ? () {
            _changeMoneyKeeper(context, ref);
                }
              : null,
          enableFeedback: isEnable,
          color: Colors.green,
          text: status,
          textStyle: textStyle ??
              TextStyle(fontSize: 5.w, fontWeight: FontWeight.bold),
          icon: icon,
        ),
      ),
    );
  }


  Future<void> _changeMoneyKeeper(
      BuildContext context, WidgetRef ref) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                title: Text('Chọn người giữ tiền'),
                content: SelectMoneyKeeper(),
                actions: <Widget>[
                  GFButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('OK'),
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          Navigator.pop(context);
                          final formatter = NumberFormat('###,###');
                          final value = formatter.parse(_textController.text);
                          if (currentStatus == OrderStatus.SHIPPING.name &&
                              value > 0) {
                            ref
                                .read(oneOrderProvider.notifier)
                                .updateStatusOrder(
                                    orderId,
                                    OrderStatus.SHIPPED_WITH_PAYMENT.name,
                                    version,
                                    null);
                          }
                          if (currentStatus == OrderStatus.SHIPPING.name &&
                              value <= 0) {
                            ref
                                .read(oneOrderProvider.notifier)
                                .updateStatusOrder(
                                    orderId,
                                    OrderStatus.SHIPPED_WITH_NONPAYMENT.name,
                                    version,
                                    null);
                          }
                        } else {
                          _textController.text = '';
                        }
                      }),
                ],
              ));
        });
  }
}

class SelectMoneyKeeper extends StatefulWidget {
  @override
  _SelectMoneyKeeperState createState() {
    return _SelectMoneyKeeperState();
  }
}

class _SelectMoneyKeeperState extends State<SelectMoneyKeeper> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            child: Row(
              children: <Widget>[
                Icon(Icons.filter_1),
                Text('Item 1'),
              ],
            ),
            value: 'one',
          ),
          DropdownMenuItem<String>(
            child: Row(
              children: <Widget>[
                Icon(Icons.filter_2),
                Text('Item 2'),
              ],
            ),
            value: 'two',
          ),
          DropdownMenuItem<String>(
            child: Row(
              children: <Widget>[
                Icon(Icons.filter_3),
                Text('Item 3'),
              ],
            ),
            value: 'three',
          ),
        ],
        isExpanded: false,
        onChanged: (String? value) {
          setState(() {
            _value = value;
          });
        },
        hint: Text('Select Item'),
        value: _value,
        underline: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))
          ),
        ),
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
        iconEnabledColor: Colors.pink,
        //        iconDisabledColor: Colors.grey,
        iconSize: 40,
      ),
    );
  }
}
