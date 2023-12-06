// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      id: json['id'] as String,
      version: json['version'] as int,
      createdOn: json['createdOn'] as String?,
      createdBy: json['createdBy'] as String?,
      code: json['code'] as String?,
      urgentContact: json['urgentContact'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      deposit: json['deposit'] == null
          ? null
          : Deposit.fromJson(json['deposit'] as Map<String, dynamic>),
      source: json['source'] as String,
      status: json['status'] as String,
      deliveryDateTime: json['deliveryDateTime'] as String,
      buyer: Buyer.fromJson(json['buyer'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentHistories: (json['paymentHistories'] as List<dynamic>)
          .map((e) => PaymentHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignmentHistories: (json['assignmentHistories'] as List<dynamic>)
          .map((e) => AssignHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : Receiver.fromJson(json['receiver'] as Map<String, dynamic>),
      assignedAccount: json['assignedAccount'] == null
          ? null
          : User.fromJson(json['assignedAccount'] as Map<String, dynamic>),
      customerMessage: json['customerMessage'] as String?,
      noteForShipper: json['noteForShipper'] as String?,
      noteForFlorist: json['noteForFlorist'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      supportedSale:
          SupportedSale.fromJson(json['supportedSale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'createdOn': instance.createdOn,
      'createdBy': instance.createdBy,
      'code': instance.code,
      'urgentContact': instance.urgentContact,
      'price': instance.price,
      'deposit': instance.deposit,
      'source': instance.source,
      'status': instance.status,
      'deliveryDateTime': instance.deliveryDateTime,
      'buyer': instance.buyer,
      'comments': instance.comments,
      'paymentHistories': instance.paymentHistories,
      'assignmentHistories': instance.assignmentHistories,
      'product': instance.product,
      'receiver': instance.receiver,
      'assignedAccount': instance.assignedAccount,
      'customerMessage': instance.customerMessage,
      'noteForShipper': instance.noteForShipper,
      'noteForFlorist': instance.noteForFlorist,
      'attachments': instance.attachments,
      'supportedSale': instance.supportedSale,
    };
