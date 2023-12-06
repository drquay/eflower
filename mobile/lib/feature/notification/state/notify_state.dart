import 'package:flutter_boilerplate/feature/notification/model/notify_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notify_state.freezed.dart';

@freezed
class NotifyState with _$NotifyState {
  const factory NotifyState.empty() = _Empty;
  const factory NotifyState.hasNotifications(List<NotifyModel> notifications) = _Has_Notifications;
}
