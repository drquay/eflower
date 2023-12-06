// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShipperRouteModel _$$_ShipperRouteModelFromJson(Map<String, dynamic> json) =>
    _$_ShipperRouteModel(
      beginLatitude: json['beginLatitude'] as String?,
      beginLongitude: json['beginLongitude'] as String?,
      endLatitude: json['endLatitude'] as String?,
      endLongitude: json['endLongitude'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_ShipperRouteModelToJson(
        _$_ShipperRouteModel instance) =>
    <String, dynamic>{
      'beginLatitude': instance.beginLatitude,
      'beginLongitude': instance.beginLongitude,
      'endLatitude': instance.endLatitude,
      'endLongitude': instance.endLongitude,
      'type': instance.type,
    };
