import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'assign_history.freezed.dart';
part 'assign_history.g.dart';
List<AssignHistory> assignHistorysFromJson(List<dynamic> data) =>
    List<AssignHistory>.from(data.map((x) => AssignHistory.fromJson(x)));

AssignHistory assignHistoryFromJson(Map<String, dynamic> json) => AssignHistory.fromJson(json);

@freezed
class AssignHistory with _$AssignHistory {
  const AssignHistory._();

  const factory AssignHistory({
      required String createdOn,
      required User personInCharse,
  }) = _AssignHistory;

  factory AssignHistory.fromJson(Map<String, dynamic> json) => _$AssignHistoryFromJson(json);
}
