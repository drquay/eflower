import 'package:flutter_boilerplate/feature/shipper/model/shipper_route_model.dart';
import 'package:flutter_boilerplate/feature/shipper/state/shipper_route_state.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ShipperRouteRepositoryProtocol {
  Future<void> beginRoute(
      {required double longitude, required double latitude});

  Future<void> endRoute(
      {required double longitude,
      required double latitude,
      required double numberOfKm});

  Future<ShipperRouteModel?> findShipperRouteByShipperId(
      {required String shipperId});
}

final shipperRouteRepositoryProvider =
    Provider((ref) => ShipperRouteRepository(ref.read));

class ShipperRouteRepository implements ShipperRouteRepositoryProtocol {
  ShipperRouteRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<void> beginRoute(
      {required double longitude, required double latitude}) async {
    final params = {
      "toLatitude":  latitude,
      "toLongitude": longitude,
      "type": ShipperRouteEnum.BEGIN.name
    };

    final response = await _api.post('shipper-routes', params);

    // if (response is APISuccess) {
    //   final value = response.value;
    //
    //   // final data = shipperRouteFromJson(value);
    //
    //   // return data;
    // }
    //
    // return null;
  }

  @override
  Future<void> endRoute(
      {required double longitude,
      required double latitude,
      required double numberOfKm}) async {
    final params = {
      "toLatitude":  latitude,
      "toLongitude":longitude ,
      "type": ShipperRouteEnum.END.name,
      "numberOfKm": numberOfKm
    };

    final response = await _api.post('shipper-routes', params);
    if(response is APIError){
      UiUtil.showAppException( const AppException.errorWithMessage( 'Lỗi khi cập nhật vi trí vui lòng thử lại sau'));
    }
    //
    // if (response is APISuccess) {
    //   final value = response.value;
    //
    //   final data = shipperRouteFromJson(value);
    //
    //   // return data;
    // }
  }

  @override
  Future<ShipperRouteModel?> findShipperRouteByShipperId(
      {required String shipperId}) async {
    final response = await _api.get('shipper-routes/shippers/$shipperId');
    response.when(
        success: (success) {},
        error: (error) {
          return ShipperRouteState.error(
              AppException.errorWithMessage(error.toString()));
        });
    if (response is APISuccess) {
      final value = response.value;
      if (value == null) {
        return ShipperRouteModel(type: ShipperRouteEnum.Initial.name);
      }
      final data = shipperRouteFromJson(value);
      if (data.endLongitude == null || data.endLatitude == null) {
        return ShipperRouteModel(
            beginLatitude: data.beginLatitude,
            beginLongitude: data.beginLongitude,
            type: ShipperRouteEnum.END.name);
      }

      return ShipperRouteModel(type: ShipperRouteEnum.BEGIN.name);
    }

    return null;
  }
}
