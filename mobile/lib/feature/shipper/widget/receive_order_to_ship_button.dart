import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/gps_provider.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/order_status_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:sizer/sizer.dart';

class ReceiveOrderToShipButton extends ConsumerWidget {
  ReceiveOrderToShipButton(
      {Key? key,
      required this.orderId,
      required this.currentStatus,
      required this.version,
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
              ? () {
                GpsModel? gpsModel;
                  ref.watch(gpsProvider).maybeWhen(isLoaded: (gps) {
                      gpsModel= GpsModel(latitude: gps.latitude, longitude: gps.longitude);
                  }, orElse: () async {
                    await ref.read(gpsProvider.notifier).getCurrentLocation();
                  });
                  if (currentStatus == OrderStatus.CUSTOMER_SATISFIED.name) {
                    ref.read(oneOrderProvider.notifier).changeOrderStatus(
                          orderId,
                          currentStatus,
                          version,
                          null,
                        gpsModel:gpsModel
                        );
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
