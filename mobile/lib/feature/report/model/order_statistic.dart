import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_statistic.freezed.dart';

part 'order_statistic.g.dart';

List<OrderStatistic> orderStatisticFromJson(List<dynamic> data) =>
    List<OrderStatistic>.from(data.map((x) => OrderStatistic.fromJson(x)));

@freezed
class OrderStatistic with _$OrderStatistic {
  const factory OrderStatistic({
    required String status,
    required int numberOfOrder,
  }) = _OrderStatistic;

  factory OrderStatistic.fromJson(Map<String, dynamic> json) =>
      _$OrderStatisticFromJson(json);
}
