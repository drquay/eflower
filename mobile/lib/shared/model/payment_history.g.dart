// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentHistory _$$_PaymentHistoryFromJson(Map<String, dynamic> json) =>
    _$_PaymentHistory(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      moneyKeeper: User.fromJson(json['moneyKeeper'] as Map<String, dynamic>),
      paymentReason: json['paymentReason'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String?,
      note: json['note'] as String?,
      createdOn: json['createdOn'] as String?,
    );

Map<String, dynamic> _$$_PaymentHistoryToJson(_$_PaymentHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'moneyKeeper': instance.moneyKeeper,
      'paymentReason': instance.paymentReason,
      'attachments': instance.attachments,
      'createdBy': instance.createdBy,
      'note': instance.note,
      'createdOn': instance.createdOn,
    };
