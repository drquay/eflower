import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/feature/report/model/order_statistic.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_statistic_state.freezed.dart';

@freezed
class OrderStatisticState with _$OrderStatisticState {
  const factory OrderStatisticState.loading() = _Loading;

  const factory OrderStatisticState.orderStatisticLoaded(
      List<OrderStatistic> orderStatistic) = _Loaded;

  const factory OrderStatisticState.error(AppException error) = _Error;
}
