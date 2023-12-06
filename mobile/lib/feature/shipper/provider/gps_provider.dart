import 'package:flutter_boilerplate/feature/shipper/repository/gps_repository.dart';
import 'package:flutter_boilerplate/feature/shipper/state/gps_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gpsProvider = StateNotifierProvider<GpsProvider, GpsState>((ref) {
  return GpsProvider(ref.read);
});

class GpsProvider extends StateNotifier<GpsState> {
  GpsProvider(this._reader) : super(GpsState.initial()) {
    _init();
  }

  final Reader _reader;
  late final GpsRepository _gpsRepository = _reader(gpsRepositoryProvider);

  Future<void> _init() async {
    await _gpsRepository.checkPermission();
  }

  Future<void> getCurrentLocation() async {
    await _gpsRepository.checkPermission();

    final response = await _gpsRepository.getCurrentLocation();
    if (mounted) {
      state = response;
    }
  }
}
