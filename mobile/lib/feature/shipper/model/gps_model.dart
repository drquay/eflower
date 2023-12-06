import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_model.freezed.dart';

@freezed
class GpsModel with _$GpsModel {
  const GpsModel._();

  const factory GpsModel({
    required double latitude,
    required double longitude,
    double? numberOfKm,
  }) = _GpsModel;
}
