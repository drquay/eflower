import 'package:flutter_boilerplate/feature/shipper/repository/payment_history_repository.dart';
import 'package:flutter_boilerplate/feature/shipper/state/payment_history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentHistoryProvider =
    StateNotifierProvider<PaymentHistoryProvider, PaymentHistoryState>(
        (ref) => PaymentHistoryProvider(ref.read));

class PaymentHistoryProvider extends StateNotifier<PaymentHistoryState> {
  PaymentHistoryProvider(this._reader) : super(PaymentHistoryState.initial());
  final Reader _reader;
  late final PaymentHistoryRepository _paymentHistoryRepository =
      _reader(paymentHistoryRepositoryProvider);

  Future<void> retrieveListPaymentHistory({required String orderId}) async {
    final list = await _paymentHistoryRepository.retrieveListPaymentHistory(
        orderId: orderId);
    if (list == null) {
      if (mounted) {
        state = PaymentHistoryState.empty();
      }
    } else {
      if (mounted) {
        list.sort((a,b)=>a.createdOn!.compareTo(b.createdOn!)*-1);
        state = PaymentHistoryState.hasValue(list);
      }
    }
  }

  Future<void> performCreatePaymentHistory(
      {required String orderId,
      required double amount,
      required String moneyKeeperId,
      required String type,
      String? note,
      String? paymentReason}) async {
    await _paymentHistoryRepository.performCreatePaymentHistory(
        orderId: orderId,
        amount: amount,
        moneyKeeperId: moneyKeeperId,
        type: type,note:note,paymentReason: paymentReason??'');
    await retrieveListPaymentHistory(orderId: orderId);
  }
  Future<void> performUpdatePaymentHistory(
      {required String orderId,
        required String paymentId,
        required double amount,
        required String moneyKeeperId,
        required String type,
        String? note}) async {
    await _paymentHistoryRepository.performUpdatePaymentHistory(
        orderId: orderId,
        amount: amount,
        moneyKeeperId: moneyKeeperId,
        type: type, paymentId: paymentId);
  }
}
