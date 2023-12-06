import 'package:freezed_annotation/freezed_annotation.dart';

part 'notify_model.freezed.dart';

part 'notify_model.g.dart';

List<NotifyModel> notificationListModelFromJson(List<dynamic> data) =>
    List<NotifyModel>.from(data.map((x) => NotifyModel.fromJson(x)));
NotifyModel notificationFromJson(dynamic json)=>NotifyModel.fromJson(json);
@freezed
class NotifyModel with _$NotifyModel {
  const factory NotifyModel({
    required String type,
    required String name,
    required String message,
    DateTime? dateTime,
  }) = _NotifyModel;

  factory NotifyModel.fromJson(Map<String, dynamic> json) =>
      _$NotifyModelFromJson(json);
}
