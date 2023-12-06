// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deposit _$$_DepositFromJson(Map<String, dynamic> json) => _$_Deposit(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      moneyKeeperId: json['moneyKeeperId'] as String?,
      paymentReason: json['paymentReason'] as String?,
      note: json['note'] as String?,
      type: json['type'] as String?,
      createdOn: json['createdOn'] as String?,
    );

Map<String, dynamic> _$$_DepositToJson(_$_Deposit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'attachments': instance.attachments,
      'moneyKeeperId': instance.moneyKeeperId,
      'paymentReason': instance.paymentReason,
      'note': instance.note,
      'type': instance.type,
      'createdOn': instance.createdOn,
    };
