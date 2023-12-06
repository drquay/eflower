import 'dart:async';

import 'package:flutter_boilerplate/app/provider/app_start_provider.dart';
import 'package:flutter_boilerplate/app/state/app_start_state.dart';
import 'package:flutter_boilerplate/feature/report/repository/order_statistic_repository.dart';
import 'package:flutter_boilerplate/feature/report/state/order_statistic_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderStatisticProvider =
    StateNotifierProvider<OrderStatisticProvider, OrderStatisticState>((ref) {
  final appStartState = ref.watch(appStartProvider);

  return OrderStatisticProvider(ref.read, appStartState);
});

class OrderStatisticProvider extends StateNotifier<OrderStatisticState> {
  OrderStatisticProvider(this._reader, this._appStartState)
      : super(const OrderStatisticState.loading()) {
    _init();
  }

  final Reader _reader;
  final AppStartState _appStartState;

  late final OrderStatisticRepository _repository =
      _reader(orderStatisticRepositoryProvider);

  Future<void> _init() async {
    _appStartState.maybeWhen(
        floristAuthenticated: () {
          orderStatistic();
          Timer.periodic(const Duration(seconds: 30), (timer) {
            if (!(_appStartState is FloritsAppAuthenticated ||
                _appStartState is ShipperAppAuthenticated)) {
              timer.cancel();
            }
            orderStatistic();
          });
        },
        shipperAuthenticated: () {
          orderStatistic();
          Timer.periodic(const Duration(seconds: 30), (timer) {
            if (!(_appStartState is FloritsAppAuthenticated ||
                _appStartState is ShipperAppAuthenticated)) {
              timer.cancel();
            }
            orderStatistic();
          });
        },
        orElse: () {});
  }

  Future<void> orderStatistic() async {
    final response = await _repository.orderStatistic();
    if (mounted) {
      state = response;
    }
  }
}
