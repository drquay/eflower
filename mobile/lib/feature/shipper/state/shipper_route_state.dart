import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipper_route_state.freezed.dart';

@freezed
class ShipperRouteState with _$ShipperRouteState {
  const factory ShipperRouteState.initial()= _Initial;
  const factory ShipperRouteState.loading()= _Loading;
  const factory ShipperRouteState.error(AppException error) = _Error;
  const factory ShipperRouteState.begin() = _Begin;
  const factory ShipperRouteState.end(GpsModel model) = _End;
}
