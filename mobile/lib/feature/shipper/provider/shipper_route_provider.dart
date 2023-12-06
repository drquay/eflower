import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/feature/shipper/repository/shipper_route_repository.dart';
import 'package:flutter_boilerplate/feature/shipper/state/shipper_route_state.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/model/token.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shipperRouteProvider =
    StateNotifierProvider<ShipperRouteProvider, ShipperRouteState>((ref) {
  return ShipperRouteProvider(ref.read);
});

class ShipperRouteProvider extends StateNotifier<ShipperRouteState> {
  ShipperRouteProvider(this._reader) : super(ShipperRouteState.loading()) {
    _init();
  }

  final Reader _reader;
  late final ShipperRouteRepository _shipperRouteRepository =
      _reader(shipperRouteRepositoryProvider);
  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);

  Future<void> _init() async {
    final token = await _tokenRepository.fetchToken();
    if (token != null) {
      await findShipperRouteByShipperId(shipperId: token.id);

    }
  }

  Future<void> beginRoute(
      {required double longitude, required double latitude,required String shipperId}) async {
    if (mounted) {
      state = ShipperRouteState.loading();
    }
    await _shipperRouteRepository.beginRoute(
        longitude: longitude, latitude: latitude);
    await findShipperRouteByShipperId(shipperId: shipperId);
  }

  Future<void> endRoute(
      {required double longitude, required double latitude,required double numberOfKm ,required String shipperId}) async {
    if (mounted) {
      state = ShipperRouteState.loading();
    }
   await _shipperRouteRepository.endRoute(longitude: longitude, latitude: latitude,numberOfKm:numberOfKm);
    await findShipperRouteByShipperId(shipperId: shipperId);
  }

  Future<void> findShipperRouteByShipperId({required String shipperId}) async {
    final response = await _shipperRouteRepository.findShipperRouteByShipperId(
        shipperId: shipperId);
    if (response != null) {
      if (mounted) {
        if (response.type == ShipperRouteEnum.END.name) {
          state = ShipperRouteState.end(GpsModel(latitude: double.parse(response.beginLatitude!),longitude:  double.parse(response.beginLongitude!)));
          return;
        }
          state = ShipperRouteState.begin();
      }
    }
  }

  String mappingShipperRouteText({required String currentStatus}) {
    if (currentStatus == ShipperRouteEnum.END.name) {
      if (mounted) {
        state = ShipperRouteState.initial();
      }
    }
    if (currentStatus == ShipperRouteEnum.Initial.name) {
      return 'Bắt đầu';
    }
    if (currentStatus == ShipperRouteEnum.BEGIN.name) {
      return 'Kết thúc';
    }

    return 'Bắt đầu';
  }

  void changeShipperRouteStatus(
      {required String shipperId,
      required double longitude,
      required double latitude,
      required double currentStatus,double?numberOfKm}) async {
    if (currentStatus == ShipperRouteEnum.Initial.name) {
      await beginRoute(longitude: longitude, latitude: latitude,shipperId: shipperId);
    }
    if (currentStatus == ShipperRouteEnum.BEGIN.name&&numberOfKm!=null) {
      await endRoute(longitude: longitude, latitude: latitude,numberOfKm: numberOfKm,shipperId: shipperId);
    }
    await findShipperRouteByShipperId(shipperId: shipperId);
  }
}
