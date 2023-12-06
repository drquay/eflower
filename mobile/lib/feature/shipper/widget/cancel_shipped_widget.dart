import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/order_status_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CancelShippedButton extends ConsumerWidget {
  CancelShippedButton(
      {Key? key,
        required this.orderId,
        required this.version,
        required this.currentStatus,
        this.assignedId,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatusUtil.mappingBtnActionFlorist(OrderStatus.ERROR.name);
    final isEnable = currentStatus != OrderStatus.ERROR.name;

    return Center(
      child: Container(
        width: width ?? 60.w,
        padding: padding ?? EdgeInsets.only(bottom: 10.w),
        child: GFButton(
          onPressed: isEnable
              ? () {
            _cancel(context);
            // if (currentStatus == OrderStatus.NEW.name) {
            //   ref
            //       .read(oneOrderProvider.notifier)
            //       .changeOrderStatus(orderId, currentStatus,version, null);
              if (onPressed != null) {
                onPressed!();
              // }
            }
          }
              : null,
          enableFeedback: isEnable,
          color: Colors.white,
          text: status,
          borderSide: const BorderSide(color:Colors.redAccent),
          textStyle: textStyle ??
              TextStyle(
                  fontSize: 5.w,
                  fontWeight: FontWeight.bold,
                color: Colors.redAccent
              ),
          icon: icon,
        ),
      ),
    );
  }
  void _cancel(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Hủy đơn'),
            content: const Text('Bạn muốn hủy đơn này không?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: const Text('Đồng ý'),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy'),
              )
            ],
          );
        });
  }
}
