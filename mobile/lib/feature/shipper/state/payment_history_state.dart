import 'package:flutter_boilerplate/feature/shipper/model/gps_model.dart';
import 'package:flutter_boilerplate/shared/model/payment_history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_history_state.freezed.dart';

@freezed
class PaymentHistoryState with _$PaymentHistoryState{
  const factory PaymentHistoryState.initial()=_Init;
  const factory PaymentHistoryState.empty() = _Empty;
  const factory PaymentHistoryState.hasValue(List<PaymentHistory> paymentHistoryList) = _HasValue;


}

