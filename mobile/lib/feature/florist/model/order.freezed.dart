// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
class _$OrderTearOff {
  const _$OrderTearOff();

  _Order call(
      {required String id,
      required int version,
      String? createdOn,
      String? createdBy,
      String? code,
      String? urgentContact,
      double? price,
      Deposit? deposit,
      required String source,
      required String status,
      required String deliveryDateTime,
      required Buyer buyer,
      required List<CommentModel> comments,
      required List<PaymentHistory> paymentHistories,
      required List<AssignHistory> assignmentHistories,
      Product? product,
      Receiver? receiver,
      User? assignedAccount,
      String? customerMessage,
      String? noteForShipper,
      String? noteForFlorist,
      List<Attachment>? attachments,
      required SupportedSale supportedSale}) {
    return _Order(
      id: id,
      version: version,
      createdOn: createdOn,
      createdBy: createdBy,
      code: code,
      urgentContact: urgentContact,
      price: price,
      deposit: deposit,
      source: source,
      status: status,
      deliveryDateTime: deliveryDateTime,
      buyer: buyer,
      comments: comments,
      paymentHistories: paymentHistories,
      assignmentHistories: assignmentHistories,
      product: product,
      receiver: receiver,
      assignedAccount: assignedAccount,
      customerMessage: customerMessage,
      noteForShipper: noteForShipper,
      noteForFlorist: noteForFlorist,
      attachments: attachments,
      supportedSale: supportedSale,
    );
  }

  Order fromJson(Map<String, Object?> json) {
    return Order.fromJson(json);
  }
}

/// @nodoc
const $Order = _$OrderTearOff();

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String? get createdOn => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get urgentContact => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  Deposit? get deposit => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get deliveryDateTime => throw _privateConstructorUsedError;
  Buyer get buyer => throw _privateConstructorUsedError;
  List<CommentModel> get comments => throw _privateConstructorUsedError;
  List<PaymentHistory> get paymentHistories =>
      throw _privateConstructorUsedError;
  List<AssignHistory> get assignmentHistories =>
      throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;
  Receiver? get receiver => throw _privateConstructorUsedError;
  User? get assignedAccount => throw _privateConstructorUsedError;
  String? get customerMessage => throw _privateConstructorUsedError;
  String? get noteForShipper => throw _privateConstructorUsedError;
  String? get noteForFlorist => throw _privateConstructorUsedError;
  List<Attachment>? get attachments => throw _privateConstructorUsedError;
  SupportedSale get supportedSale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res>;
  $Res call(
      {String id,
      int version,
      String? createdOn,
      String? createdBy,
      String? code,
      String? urgentContact,
      double? price,
      Deposit? deposit,
      String source,
      String status,
      String deliveryDateTime,
      Buyer buyer,
      List<CommentModel> comments,
      List<PaymentHistory> paymentHistories,
      List<AssignHistory> assignmentHistories,
      Product? product,
      Receiver? receiver,
      User? assignedAccount,
      String? customerMessage,
      String? noteForShipper,
      String? noteForFlorist,
      List<Attachment>? attachments,
      SupportedSale supportedSale});

  $DepositCopyWith<$Res>? get deposit;
  $BuyerCopyWith<$Res> get buyer;
  $ProductCopyWith<$Res>? get product;
  $ReceiverCopyWith<$Res>? get receiver;
  $UserCopyWith<$Res>? get assignedAccount;
  $SupportedSaleCopyWith<$Res> get supportedSale;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  final Order _value;
  // ignore: unused_field
  final $Res Function(Order) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? version = freezed,
    Object? createdOn = freezed,
    Object? createdBy = freezed,
    Object? code = freezed,
    Object? urgentContact = freezed,
    Object? price = freezed,
    Object? deposit = freezed,
    Object? source = freezed,
    Object? status = freezed,
    Object? deliveryDateTime = freezed,
    Object? buyer = freezed,
    Object? comments = freezed,
    Object? paymentHistories = freezed,
    Object? assignmentHistories = freezed,
    Object? product = freezed,
    Object? receiver = freezed,
    Object? assignedAccount = freezed,
    Object? customerMessage = freezed,
    Object? noteForShipper = freezed,
    Object? noteForFlorist = freezed,
    Object? attachments = freezed,
    Object? supportedSale = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      urgentContact: urgentContact == freezed
          ? _value.urgentContact
          : urgentContact // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      deposit: deposit == freezed
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as Deposit?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDateTime: deliveryDateTime == freezed
          ? _value.deliveryDateTime
          : deliveryDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      buyer: buyer == freezed
          ? _value.buyer
          : buyer // ignore: cast_nullable_to_non_nullable
              as Buyer,
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
      paymentHistories: paymentHistories == freezed
          ? _value.paymentHistories
          : paymentHistories // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistory>,
      assignmentHistories: assignmentHistories == freezed
          ? _value.assignmentHistories
          : assignmentHistories // ignore: cast_nullable_to_non_nullable
              as List<AssignHistory>,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      receiver: receiver == freezed
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as Receiver?,
      assignedAccount: assignedAccount == freezed
          ? _value.assignedAccount
          : assignedAccount // ignore: cast_nullable_to_non_nullable
              as User?,
      customerMessage: customerMessage == freezed
          ? _value.customerMessage
          : customerMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteForShipper: noteForShipper == freezed
          ? _value.noteForShipper
          : noteForShipper // ignore: cast_nullable_to_non_nullable
              as String?,
      noteForFlorist: noteForFlorist == freezed
          ? _value.noteForFlorist
          : noteForFlorist // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      supportedSale: supportedSale == freezed
          ? _value.supportedSale
          : supportedSale // ignore: cast_nullable_to_non_nullable
              as SupportedSale,
    ));
  }

  @override
  $DepositCopyWith<$Res>? get deposit {
    if (_value.deposit == null) {
      return null;
    }

    return $DepositCopyWith<$Res>(_value.deposit!, (value) {
      return _then(_value.copyWith(deposit: value));
    });
  }

  @override
  $BuyerCopyWith<$Res> get buyer {
    return $BuyerCopyWith<$Res>(_value.buyer, (value) {
      return _then(_value.copyWith(buyer: value));
    });
  }

  @override
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value));
    });
  }

  @override
  $ReceiverCopyWith<$Res>? get receiver {
    if (_value.receiver == null) {
      return null;
    }

    return $ReceiverCopyWith<$Res>(_value.receiver!, (value) {
      return _then(_value.copyWith(receiver: value));
    });
  }

  @override
  $UserCopyWith<$Res>? get assignedAccount {
    if (_value.assignedAccount == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.assignedAccount!, (value) {
      return _then(_value.copyWith(assignedAccount: value));
    });
  }

  @override
  $SupportedSaleCopyWith<$Res> get supportedSale {
    return $SupportedSaleCopyWith<$Res>(_value.supportedSale, (value) {
      return _then(_value.copyWith(supportedSale: value));
    });
  }
}

/// @nodoc
abstract class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) then) =
      __$OrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      int version,
      String? createdOn,
      String? createdBy,
      String? code,
      String? urgentContact,
      double? price,
      Deposit? deposit,
      String source,
      String status,
      String deliveryDateTime,
      Buyer buyer,
      List<CommentModel> comments,
      List<PaymentHistory> paymentHistories,
      List<AssignHistory> assignmentHistories,
      Product? product,
      Receiver? receiver,
      User? assignedAccount,
      String? customerMessage,
      String? noteForShipper,
      String? noteForFlorist,
      List<Attachment>? attachments,
      SupportedSale supportedSale});

  @override
  $DepositCopyWith<$Res>? get deposit;
  @override
  $BuyerCopyWith<$Res> get buyer;
  @override
  $ProductCopyWith<$Res>? get product;
  @override
  $ReceiverCopyWith<$Res>? get receiver;
  @override
  $UserCopyWith<$Res>? get assignedAccount;
  @override
  $SupportedSaleCopyWith<$Res> get supportedSale;
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(_Order _value, $Res Function(_Order) _then)
      : super(_value, (v) => _then(v as _Order));

  @override
  _Order get _value => super._value as _Order;

  @override
  $Res call({
    Object? id = freezed,
    Object? version = freezed,
    Object? createdOn = freezed,
    Object? createdBy = freezed,
    Object? code = freezed,
    Object? urgentContact = freezed,
    Object? price = freezed,
    Object? deposit = freezed,
    Object? source = freezed,
    Object? status = freezed,
    Object? deliveryDateTime = freezed,
    Object? buyer = freezed,
    Object? comments = freezed,
    Object? paymentHistories = freezed,
    Object? assignmentHistories = freezed,
    Object? product = freezed,
    Object? receiver = freezed,
    Object? assignedAccount = freezed,
    Object? customerMessage = freezed,
    Object? noteForShipper = freezed,
    Object? noteForFlorist = freezed,
    Object? attachments = freezed,
    Object? supportedSale = freezed,
  }) {
    return _then(_Order(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      urgentContact: urgentContact == freezed
          ? _value.urgentContact
          : urgentContact // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      deposit: deposit == freezed
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as Deposit?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDateTime: deliveryDateTime == freezed
          ? _value.deliveryDateTime
          : deliveryDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      buyer: buyer == freezed
          ? _value.buyer
          : buyer // ignore: cast_nullable_to_non_nullable
              as Buyer,
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
      paymentHistories: paymentHistories == freezed
          ? _value.paymentHistories
          : paymentHistories // ignore: cast_nullable_to_non_nullable
              as List<PaymentHistory>,
      assignmentHistories: assignmentHistories == freezed
          ? _value.assignmentHistories
          : assignmentHistories // ignore: cast_nullable_to_non_nullable
              as List<AssignHistory>,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      receiver: receiver == freezed
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as Receiver?,
      assignedAccount: assignedAccount == freezed
          ? _value.assignedAccount
          : assignedAccount // ignore: cast_nullable_to_non_nullable
              as User?,
      customerMessage: customerMessage == freezed
          ? _value.customerMessage
          : customerMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteForShipper: noteForShipper == freezed
          ? _value.noteForShipper
          : noteForShipper // ignore: cast_nullable_to_non_nullable
              as String?,
      noteForFlorist: noteForFlorist == freezed
          ? _value.noteForFlorist
          : noteForFlorist // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      supportedSale: supportedSale == freezed
          ? _value.supportedSale
          : supportedSale // ignore: cast_nullable_to_non_nullable
              as SupportedSale,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Order extends _Order {
  const _$_Order(
      {required this.id,
      required this.version,
      this.createdOn,
      this.createdBy,
      this.code,
      this.urgentContact,
      this.price,
      this.deposit,
      required this.source,
      required this.status,
      required this.deliveryDateTime,
      required this.buyer,
      required this.comments,
      required this.paymentHistories,
      required this.assignmentHistories,
      this.product,
      this.receiver,
      this.assignedAccount,
      this.customerMessage,
      this.noteForShipper,
      this.noteForFlorist,
      this.attachments,
      required this.supportedSale})
      : super._();

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$$_OrderFromJson(json);

  @override
  final String id;
  @override
  final int version;
  @override
  final String? createdOn;
  @override
  final String? createdBy;
  @override
  final String? code;
  @override
  final String? urgentContact;
  @override
  final double? price;
  @override
  final Deposit? deposit;
  @override
  final String source;
  @override
  final String status;
  @override
  final String deliveryDateTime;
  @override
  final Buyer buyer;
  @override
  final List<CommentModel> comments;
  @override
  final List<PaymentHistory> paymentHistories;
  @override
  final List<AssignHistory> assignmentHistories;
  @override
  final Product? product;
  @override
  final Receiver? receiver;
  @override
  final User? assignedAccount;
  @override
  final String? customerMessage;
  @override
  final String? noteForShipper;
  @override
  final String? noteForFlorist;
  @override
  final List<Attachment>? attachments;
  @override
  final SupportedSale supportedSale;

  @override
  String toString() {
    return 'Order(id: $id, version: $version, createdOn: $createdOn, createdBy: $createdBy, code: $code, urgentContact: $urgentContact, price: $price, deposit: $deposit, source: $source, status: $status, deliveryDateTime: $deliveryDateTime, buyer: $buyer, comments: $comments, paymentHistories: $paymentHistories, assignmentHistories: $assignmentHistories, product: $product, receiver: $receiver, assignedAccount: $assignedAccount, customerMessage: $customerMessage, noteForShipper: $noteForShipper, noteForFlorist: $noteForFlorist, attachments: $attachments, supportedSale: $supportedSale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.version, version) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn) &&
            const DeepCollectionEquality().equals(other.createdBy, createdBy) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.urgentContact, urgentContact) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.deposit, deposit) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.deliveryDateTime, deliveryDateTime) &&
            const DeepCollectionEquality().equals(other.buyer, buyer) &&
            const DeepCollectionEquality().equals(other.comments, comments) &&
            const DeepCollectionEquality()
                .equals(other.paymentHistories, paymentHistories) &&
            const DeepCollectionEquality()
                .equals(other.assignmentHistories, assignmentHistories) &&
            const DeepCollectionEquality().equals(other.product, product) &&
            const DeepCollectionEquality().equals(other.receiver, receiver) &&
            const DeepCollectionEquality()
                .equals(other.assignedAccount, assignedAccount) &&
            const DeepCollectionEquality()
                .equals(other.customerMessage, customerMessage) &&
            const DeepCollectionEquality()
                .equals(other.noteForShipper, noteForShipper) &&
            const DeepCollectionEquality()
                .equals(other.noteForFlorist, noteForFlorist) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            const DeepCollectionEquality()
                .equals(other.supportedSale, supportedSale));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(version),
        const DeepCollectionEquality().hash(createdOn),
        const DeepCollectionEquality().hash(createdBy),
        const DeepCollectionEquality().hash(code),
        const DeepCollectionEquality().hash(urgentContact),
        const DeepCollectionEquality().hash(price),
        const DeepCollectionEquality().hash(deposit),
        const DeepCollectionEquality().hash(source),
        const DeepCollectionEquality().hash(status),
        const DeepCollectionEquality().hash(deliveryDateTime),
        const DeepCollectionEquality().hash(buyer),
        const DeepCollectionEquality().hash(comments),
        const DeepCollectionEquality().hash(paymentHistories),
        const DeepCollectionEquality().hash(assignmentHistories),
        const DeepCollectionEquality().hash(product),
        const DeepCollectionEquality().hash(receiver),
        const DeepCollectionEquality().hash(assignedAccount),
        const DeepCollectionEquality().hash(customerMessage),
        const DeepCollectionEquality().hash(noteForShipper),
        const DeepCollectionEquality().hash(noteForFlorist),
        const DeepCollectionEquality().hash(attachments),
        const DeepCollectionEquality().hash(supportedSale)
      ]);

  @JsonKey(ignore: true)
  @override
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderToJson(this);
  }
}

abstract class _Order extends Order {
  const factory _Order(
      {required String id,
      required int version,
      String? createdOn,
      String? createdBy,
      String? code,
      String? urgentContact,
      double? price,
      Deposit? deposit,
      required String source,
      required String status,
      required String deliveryDateTime,
      required Buyer buyer,
      required List<CommentModel> comments,
      required List<PaymentHistory> paymentHistories,
      required List<AssignHistory> assignmentHistories,
      Product? product,
      Receiver? receiver,
      User? assignedAccount,
      String? customerMessage,
      String? noteForShipper,
      String? noteForFlorist,
      List<Attachment>? attachments,
      required SupportedSale supportedSale}) = _$_Order;
  const _Order._() : super._();

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  String get id;
  @override
  int get version;
  @override
  String? get createdOn;
  @override
  String? get createdBy;
  @override
  String? get code;
  @override
  String? get urgentContact;
  @override
  double? get price;
  @override
  Deposit? get deposit;
  @override
  String get source;
  @override
  String get status;
  @override
  String get deliveryDateTime;
  @override
  Buyer get buyer;
  @override
  List<CommentModel> get comments;
  @override
  List<PaymentHistory> get paymentHistories;
  @override
  List<AssignHistory> get assignmentHistories;
  @override
  Product? get product;
  @override
  Receiver? get receiver;
  @override
  User? get assignedAccount;
  @override
  String? get customerMessage;
  @override
  String? get noteForShipper;
  @override
  String? get noteForFlorist;
  @override
  List<Attachment>? get attachments;
  @override
  SupportedSale get supportedSale;
  @override
  @JsonKey(ignore: true)
  _$OrderCopyWith<_Order> get copyWith => throw _privateConstructorUsedError;
}
