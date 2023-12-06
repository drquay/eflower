import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_state.freezed.dart';

@freezed
class GpsState with _$GpsState{
  const factory GpsState.initial() = _Initial;
  const factory GpsState.loading() = _LoadingAccess;
  const factory GpsState.isDenied() = _DeniedAccess;
  const factory GpsState.isPermanentlyDenied() = _PermanentlyDeniedAccess;
  const factory GpsState.isGrantedAccess() = _GrantedAccess;
  const factory GpsState.isLoaded(GpsModel gps) = _LoadedAccess;

}

