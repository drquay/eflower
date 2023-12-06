import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/feature/history/widget/create_history_widget.dart';
import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/gps_provider.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/shipper_route_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/gpsUtils.dart';
import 'package:flutter_boilerplate/shared/util/order_status_util.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ConfirmShippedButton extends ConsumerWidget {
  ConfirmShippedButton(
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
  GpsModel? gpsModel;
  bool isError= true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatusUtil.mappingBtnActionFlorist(currentStatus);
    final isEnable = currentStatus != OrderStatus.FINISHED.name &&
        currentStatus != OrderStatus.ERROR.name;
    ref.watch(gpsProvider).maybeWhen(isLoaded: (gps) {
      gpsModel= GpsModel(latitude: gps.latitude, longitude: gps.longitude);
    }, orElse: () async {
      await ref.read(gpsProvider.notifier).getCurrentLocation();
    });
     ref.watch(shipperRouteProvider).maybeWhen(end: (gps) {
       final numberOfKms = GpsUtils.calculateDistance(
           gps.latitude, gps.longitude, gpsModel?.latitude,
           gpsModel?.longitude);
       gpsModel = gpsModel?.copyWith(numberOfKm: numberOfKms);
       isError=false;
     }, orElse: () {
       isError=true;
     });

    return Center(
      child: Container(
        width: width ?? 60.w,
        padding: padding ?? EdgeInsets.only(bottom: 10.w),
        child: GFButton(
          onPressed: isEnable
              ? () {
                  if([OrderStatus.SHIPPED_WITH_PAYMENT.name,OrderStatus.SHIPPED_WITH_NONPAYMENT.name,OrderStatus.FINISHED.name].contains(currentStatus)){
                    Get.to(()=>CreateHistoryWidget(orderId));
                  }
                  else {
                    _confirm(context, ref);
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

  void _confirm(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Xác nhận'),
            content: const Text('Đánh dấu đơn hàng này đã được giao?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final _files = files==null||files!.isEmpty?List<File>.empty():files!.map((e) => File(e.path)).toList();

                  if (currentStatus == OrderStatus.SALE_REJECTED.name) {
                    return UiUtil.showAlertAppException("Cảnh báo",
                        "Đơn này đã bị Sale từ chối, vui lòng cập nhật và dừng làm đơn này");
                  }

                  if ((files == null || files!.isEmpty) &&
                      currentStatus == OrderStatus.SHIPPING.name) {
                    return UiUtil.showAlertAppException('Thiếu ảnh',
                        'Bạn cần tải lên ít 1 ảnh trước khi hoàn thành');
                  }
                  if (currentStatus == OrderStatus.SHIPPING.name && assignedId != null) {
                      if(isError) {
                        UiUtil.showAlertAppException('Cảnh báo',
                            'Bạn phải bắt đầu hành trình giao hàng trước khi đánh dấu hoàn thành. Vui lòng ra trang chính để có thể bắt đầu');
                      }
                      else{
                        UiUtil.showNormalAlert('Xác nhận','Bạn đã thu đủ tiền chưa',(){
                           ref
                              .read(oneOrderProvider.notifier)
                              .changeStatusToDone(
                              currentStatus,
                              orderId,
                              version,
                              _files,
                              assignedId!,gpsModel: gpsModel);
                          if (onPressed != null) {
                            onPressed!();
                          }
                        });

                    }
                  }else{
                    UiUtil.showAlertAppException('Cảnh báo',
                        'Đơn hàng đã được thay đổi, vui lòng cập nhật');
                  }
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
                isDefaultAction: false,
                isDestructiveAction: false,
                child: const Text('Hủy'),
              )
            ],
          );
        });
  }
  //
  // Future<void> _displayTextInputDialog(
  //     BuildContext context, WidgetRef ref) async {
  //   return showDialog(
  //       barrierDismissible: true,
  //       context: context,
  //       builder: (context) {
  //         return WillPopScope(
  //             onWillPop: () => Future.value(false),
  //             child: AlertDialog(
  //               title: Text('Nhập số tiền giữ từ đơn hàng'),
  //               content: TextField(
  //                 inputFormatters: [
  //                   FilteringTextInputFormatter.digitsOnly,
  //                   LengthLimitingTextInputFormatter(9),
  //                 ],
  //                 controller: _textController,
  //                 decoration: InputDecoration(hintText: 'Nhập số tiền ...'),
  //                 keyboardType: TextInputType.number,
  //                   onEditingComplete: (){
  //                     final formatter = NumberFormat('###,###');
  //                     _textController.text=formatter.format(double.parse(_textController.text)).toString();}
  //               ),
  //               actions: <Widget>[
  //                 GFButton(
  //                     color: Colors.green,
  //                     textColor: Colors.white,
  //                     child: Text('OK'),
  //                     onPressed: () {
  //                       if (_textController.text.isNotEmpty) {
  //                         Navigator.pop(context);
  //                         final formatter = NumberFormat('###,###');
  //                         final value = formatter.parse(_textController.text);
  //                         GpsModel? gpsModel;
  //                         ref.watch(gpsProvider).maybeWhen(isLoaded: (gps) {
  //                           gpsModel= GpsModel(latitude: gps.latitude, longitude: gps.longitude);
  //                         }, orElse: () async {
  //                           await ref.read(gpsProvider.notifier).getCurrentLocation();
  //                         });
  //                         if (currentStatus == OrderStatus.SHIPPING.name &&
  //                             value > 0) {
  //                           ref
  //                               .read(oneOrderProvider.notifier)
  //                               .updateStatusOrder(
  //                                   orderId,
  //                                   OrderStatus.SHIPPED_WITH_PAYMENT.name,
  //                                   version,
  //                                   null,gpsModel: gpsModel);
  //                         }
  //                         if (currentStatus == OrderStatus.SHIPPING.name &&
  //                             value <= 0) {
  //                           ref
  //                               .read(oneOrderProvider.notifier)
  //                               .updateStatusOrder(
  //                                   orderId,
  //                                   OrderStatus.SHIPPED_WITH_NONPAYMENT.name,
  //                                   version,
  //                                   null,gpsModel: gpsModel);
  //                         }
  //                       }
  //                       else{
  //                         _textController.text='';
  //                       }
  //                     }),
  //               ],
  //             ));
  //       });
  // }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    final formatter = NumberFormat('###,###');

    final value = formatter.parse(newValue.text);

    String newText = formatter.format(value);

    return newValue.copyWith(text: newText);
  }
}
