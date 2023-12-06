import 'package:flutter_boilerplate/feature/report/model/order_statistic.dart';
import 'package:flutter_boilerplate/feature/report/state/order_statistic_state.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OrderStatisticRepositoryProtocol {
  Future<OrderStatisticState> orderStatistic();
}

final orderStatisticRepositoryProvider =
    Provider((ref) => OrderStatisticRepository(ref.read));

class OrderStatisticRepository implements OrderStatisticRepositoryProtocol {
  OrderStatisticRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  @override
  Future<OrderStatisticState> orderStatistic() async {
    final response = await _api.get('reports/order-statistic');

    response.when(
      success: (success) {},
      error: (error) {
        return OrderStatisticState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final _orderStatistic = orderStatisticFromJson(value);

        return OrderStatisticState.orderStatisticLoaded(_orderStatistic);
      } catch (e) {
        return OrderStatisticState.error(
            AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return OrderStatisticState.error(response.exception);
    } else {
      return const OrderStatisticState.loading();
    }
  }
}
