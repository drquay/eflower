import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/order_status_util.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ButtonProcessing extends ConsumerWidget {
  ButtonProcessing(
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatusUtil.mappingBtnActionFlorist(currentStatus);
    final isEnable = currentStatus != OrderStatus.DONE.name;

    return Center(
      child: Container(
        width: width ?? 60.w,
        padding: padding ?? EdgeInsets.only(bottom: 10.w),
        child: GFButton(
          onPressed: isEnable
              ? () async {
                  if (currentStatus == OrderStatus.SALE_REJECTED.name) {
                    return UiUtil.showAlertAppException("Cảnh báo",
                        "Đơn này đã bị Sale từ chối, vui lòng cập nhật và dừng làm đơn này");
                  }

                  if ((files == null || files!.isEmpty) &&
                      ([
                        OrderStatus.SALE_REJECTED.name,
                        OrderStatus.CUSTOMER_REJECTED.name,
                        OrderStatus.DOING.name
                      ].contains(currentStatus))) {
                    return UiUtil.showAlertAppException('Thiếu ảnh',
                        'Bạn cần tải lên ít 1 ảnh trước khi hoàn thành');
                  }
                  if (currentStatus == OrderStatus.CUSTOMER_REJECTED.name &&
                      assignedId != null) {
                    final _files = files == null || files!.isEmpty
                        ? List<File>.empty()
                        : files!.map((e) => File(e.path)).toList();
                    await ref
                        .read(oneOrderProvider.notifier)
                        .changeStatusToDone(currentStatus, orderId, version,
                            _files, assignedId!);
                    if (onPressed != null) {
                      onPressed!();
                    }
                  }
                  if (files != null &&
                      currentStatus == OrderStatus.DOING.name) {
                    if (files!.isNotEmpty && assignedId != null) {
                      final _files = files!.map((e) => File(e.path)).toList();
                      await ref
                          .read(oneOrderProvider.notifier)
                          .changeStatusToDone(currentStatus, orderId, version,
                              _files, assignedId!);
                      if (onPressed != null) {
                        onPressed!();
                      }
                    }
                  }
                  if (currentStatus == OrderStatus.NEW.name) {
                    ref.read(oneOrderProvider.notifier).changeOrderStatus(
                        orderId, currentStatus, version, assignedId);
                    if (onPressed != null) {
                      onPressed!();
                    }
                  }
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
}
