import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/gps_provider.dart';
import 'package:flutter_boilerplate/feature/shipper/provider/shipper_route_provider.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_boilerplate/shared/util/gpsUtils.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class ShipperTrackStatusWidget extends ConsumerWidget {
   ShipperTrackStatusWidget(this.isEnable, {Key? key}) : super(key: key);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  String userId = '';
  final bool isEnable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentStatus = '';
    Color color = Colors.green;
    VoidCallback? onPressed;

    ref.watch(tokenProvider).maybeWhen(
        hasValue: (token) {
          userId = token.id;
        },
        orElse: () {});
    double? longtitude;
    double? latitude;
    ref.watch(gpsProvider).maybeWhen(isLoaded: (gps) {
      longtitude = gps.longitude;
      latitude = gps.latitude;
    }, orElse: () async {
      await ref.read(gpsProvider.notifier).getCurrentLocation();
    });
    ref.watch(shipperRouteProvider).when(begin:  () async {
      currentStatus = 'Bắt đầu';
      onPressed = isEnable?() {
        if (longtitude != null && latitude != null) {
          ref.read(shipperRouteProvider.notifier).beginRoute(
              longitude: longtitude!, latitude: latitude!, shipperId: userId);
        }
      }:null;
      await ref.read(gpsProvider.notifier).getCurrentLocation();
    }, loading: () {
      onPressed = null;
      currentStatus = '...';
    }, error: (error) {
      UiUtil.showAppException(error);
    }, end: (GpsModel gpsModel) async {
      color=Colors.red;
      currentStatus = 'Kết thúc';
      onPressed = !isEnable?() {
        if (longtitude != null && latitude != null) {
          final numberOfKm = GpsUtils.calculateDistance(
              gpsModel.latitude, gpsModel.longitude, latitude, longtitude);
          ref.read(shipperRouteProvider.notifier).endRoute(
              longitude: longtitude!,
              latitude: latitude!,
              numberOfKm: numberOfKm,
              shipperId: userId);
        }
      }:null;
      await ref.read(gpsProvider.notifier).getCurrentLocation();
    }, initial:() {
      onPressed = null;
    });

     return buttonShipperRoute(currentStatus, onPressed,color);
  }

  Widget buttonShipperRoute(String currentStatus, VoidCallback? onPressed,Color color) {
    return
      ElevatedButton.icon(
        label: Text(currentStatus),
    style: ButtonStyle(
    backgroundColor:
    MaterialStateProperty.all<Color>(color)),
    icon: const Icon(Icons.local_shipping_outlined),
    onPressed: onPressed,
    );

  }
}
