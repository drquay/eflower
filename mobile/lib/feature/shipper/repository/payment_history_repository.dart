import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/api_provider.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/payment_history.dart';
import 'package:flutter_boilerplate/shared/util/ui_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentHistoryRepositoryProvider =
Provider((ref) => PaymentHistoryRepository(ref.read));

class PaymentHistoryRepository {
  PaymentHistoryRepository(this._reader);

  late final ApiProvider _api = _reader(apiProvider);
  final Reader _reader;

  Future<List<PaymentHistory>?> retrieveListPaymentHistory({required String orderId}) async {
    final response = await _api.get('orders/$orderId');
    response.when(
      success: (success) {},
      error: (error) {
        UiUtil.showAppExceptionFromBottom(
          const AppException.errorWithMessage('Đã có lỗi xảy ra'),
        );
      },
    );
    if (response is APISuccess) {
      final value = response.value;
      try {
        final _orders =Order.fromJson(value);;

         return _orders.paymentHistories;

        } catch (e) {
        UiUtil.showAppExceptionFromBottom(
          const AppException.errorWithMessage('Đã có lỗi xảy ra'),
        );
      }
    }

    return null;
  }

  Future<void> performCreatePaymentHistory(
      {required String orderId,
      required double amount,
      required String moneyKeeperId,
      required String type,
      String? note,
      String paymentReason = 'Other'}) async {
    final params={
        'amount': amount,
        'attachmentIds': [
        ],
        'moneyKeeperId': moneyKeeperId,
        'note': note,
        'type': type
      };

    final response = await _api.post('orders/$orderId/payments',params);

  }

  Future<void> performUpdatePaymentHistory(
      {required String orderId, required String paymentId,
        required double amount,
        required String moneyKeeperId,
        required String type}) async {
    final params={
      'amount': amount,
      'attachmentIds': [
      ],
      'moneyKeeperId': moneyKeeperId,
      'type': type
    };
    final response = await _api.put('orders/$orderId/payments/$paymentId',params);
  }
}
