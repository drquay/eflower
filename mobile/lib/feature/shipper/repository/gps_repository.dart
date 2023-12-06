import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/feature/shipper/state/gps_state.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

abstract class GpsRepositoryProtocol {
  Future<GpsState> getCurrentLocation();

  Future<bool> checkPermission();
}

final gpsRepositoryProvider = Provider((ref) => GpsRepository(ref.read));

class GpsRepository implements GpsRepositoryProtocol {
  GpsRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<bool> checkPermission() async {
    var serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        } else if (permission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Future<GpsState> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final long = position.longitude;
    final lat = position.latitude;

    return GpsState.isLoaded(GpsModel(longitude: long, latitude: lat));
  }
}
