import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipper_route_model.freezed.dart';

part 'shipper_route_model.g.dart';

ShipperRouteModel shipperRouteFromJson(Map<String, dynamic> json) =>
    ShipperRouteModel.fromJson(json);

List<ShipperRouteModel> shipperRoutesFromJson(List<dynamic> json) =>
    List<ShipperRouteModel>.from(
        json.map((e) => ShipperRouteModel.fromJson(e)));

@freezed
class ShipperRouteModel with _$ShipperRouteModel {
  const ShipperRouteModel._();

  const factory ShipperRouteModel(
      {String? beginLatitude,
        String? beginLongitude,
        String? endLatitude,
        String? endLongitude,
      String? type}) = _ShipperRouteModel;

  factory ShipperRouteModel.fromJson(Map<String, dynamic> json) =>
      _$ShipperRouteModelFromJson(json);
}
