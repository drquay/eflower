import 'package:freezed_annotation/freezed_annotation.dart';

part 'receiver.freezed.dart';
part 'receiver.g.dart';

List<Receiver> receiversFromJson(List<dynamic> data) =>
    List<Receiver>.from(data.map((x) => Receiver.fromJson(x)));

Receiver receiverFromJson(Map<String, dynamic> json) => Receiver.fromJson(json);

@freezed
class Receiver with _$Receiver {
  const Receiver._();

  const factory Receiver({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) = _Receiver;

  factory Receiver.fromJson(Map<String, dynamic> json) =>
      _$ReceiverFromJson(json);
}
