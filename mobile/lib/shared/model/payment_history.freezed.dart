// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) {
  return _PaymentHistory.fromJson(json);
}

/// @nodoc
class _$PaymentHistoryTearOff {
  const _$PaymentHistoryTearOff();

  _PaymentHistory call(
      {required String id,
      required String type,
      required double amount,
      required User moneyKeeper,
      required String paymentReason,
      required List<Attachment> attachments,
      String? createdBy,
      String? note,
      String? createdOn}) {
    return _PaymentHistory(
      id: id,
      type: type,
      amount: amount,
      moneyKeeper: moneyKeeper,
      paymentReason: paymentReason,
      attachments: attachments,
      createdBy: createdBy,
      note: note,
      createdOn: createdOn,
    );
  }

  PaymentHistory fromJson(Map<String, Object?> json) {
    return PaymentHistory.fromJson(json);
  }
}

/// @nodoc
const $PaymentHistory = _$PaymentHistoryTearOff();

/// @nodoc
mixin _$PaymentHistory {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  User get moneyKeeper => throw _privateConstructorUsedError;
  String get paymentReason => throw _privateConstructorUsedError;
  List<Attachment> get attachments => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentHistoryCopyWith<PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryCopyWith<$Res> {
  factory $PaymentHistoryCopyWith(
          PaymentHistory value, $Res Function(PaymentHistory) then) =
      _$PaymentHistoryCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String type,
      double amount,
      User moneyKeeper,
      String paymentReason,
      List<Attachment> attachments,
      String? createdBy,
      String? note,
      String? createdOn});

  $UserCopyWith<$Res> get moneyKeeper;
}

/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._value, this._then);

  final PaymentHistory _value;
  // ignore: unused_field
  final $Res Function(PaymentHistory) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? moneyKeeper = freezed,
    Object? paymentReason = freezed,
    Object? attachments = freezed,
    Object? createdBy = freezed,
    Object? note = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      moneyKeeper: moneyKeeper == freezed
          ? _value.moneyKeeper
          : moneyKeeper // ignore: cast_nullable_to_non_nullable
              as User,
      paymentReason: paymentReason == freezed
          ? _value.paymentReason
          : paymentReason // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $UserCopyWith<$Res> get moneyKeeper {
    return $UserCopyWith<$Res>(_value.moneyKeeper, (value) {
      return _then(_value.copyWith(moneyKeeper: value));
    });
  }
}

/// @nodoc
abstract class _$PaymentHistoryCopyWith<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  factory _$PaymentHistoryCopyWith(
          _PaymentHistory value, $Res Function(_PaymentHistory) then) =
      __$PaymentHistoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String type,
      double amount,
      User moneyKeeper,
      String paymentReason,
      List<Attachment> attachments,
      String? createdBy,
      String? note,
      String? createdOn});

  @override
  $UserCopyWith<$Res> get moneyKeeper;
}

/// @nodoc
class __$PaymentHistoryCopyWithImpl<$Res>
    extends _$PaymentHistoryCopyWithImpl<$Res>
    implements _$PaymentHistoryCopyWith<$Res> {
  __$PaymentHistoryCopyWithImpl(
      _PaymentHistory _value, $Res Function(_PaymentHistory) _then)
      : super(_value, (v) => _then(v as _PaymentHistory));

  @override
  _PaymentHistory get _value => super._value as _PaymentHistory;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? moneyKeeper = freezed,
    Object? paymentReason = freezed,
    Object? attachments = freezed,
    Object? createdBy = freezed,
    Object? note = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_PaymentHistory(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      moneyKeeper: moneyKeeper == freezed
          ? _value.moneyKeeper
          : moneyKeeper // ignore: cast_nullable_to_non_nullable
              as User,
      paymentReason: paymentReason == freezed
          ? _value.paymentReason
          : paymentReason // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentHistory extends _PaymentHistory {
  const _$_PaymentHistory(
      {required this.id,
      required this.type,
      required this.amount,
      required this.moneyKeeper,
      required this.paymentReason,
      required this.attachments,
      this.createdBy,
      this.note,
      this.createdOn})
      : super._();

  factory _$_PaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentHistoryFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final double amount;
  @override
  final User moneyKeeper;
  @override
  final String paymentReason;
  @override
  final List<Attachment> attachments;
  @override
  final String? createdBy;
  @override
  final String? note;
  @override
  final String? createdOn;

  @override
  String toString() {
    return 'PaymentHistory(id: $id, type: $type, amount: $amount, moneyKeeper: $moneyKeeper, paymentReason: $paymentReason, attachments: $attachments, createdBy: $createdBy, note: $note, createdOn: $createdOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaymentHistory &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.moneyKeeper, moneyKeeper) &&
            const DeepCollectionEquality()
                .equals(other.paymentReason, paymentReason) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            const DeepCollectionEquality().equals(other.createdBy, createdBy) &&
            const DeepCollectionEquality().equals(other.note, note) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(moneyKeeper),
      const DeepCollectionEquality().hash(paymentReason),
      const DeepCollectionEquality().hash(attachments),
      const DeepCollectionEquality().hash(createdBy),
      const DeepCollectionEquality().hash(note),
      const DeepCollectionEquality().hash(createdOn));

  @JsonKey(ignore: true)
  @override
  _$PaymentHistoryCopyWith<_PaymentHistory> get copyWith =>
      __$PaymentHistoryCopyWithImpl<_PaymentHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentHistoryToJson(this);
  }
}

abstract class _PaymentHistory extends PaymentHistory {
  const factory _PaymentHistory(
      {required String id,
      required String type,
      required double amount,
      required User moneyKeeper,
      required String paymentReason,
      required List<Attachment> attachments,
      String? createdBy,
      String? note,
      String? createdOn}) = _$_PaymentHistory;
  const _PaymentHistory._() : super._();

  factory _PaymentHistory.fromJson(Map<String, dynamic> json) =
      _$_PaymentHistory.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  double get amount;
  @override
  User get moneyKeeper;
  @override
  String get paymentReason;
  @override
  List<Attachment> get attachments;
  @override
  String? get createdBy;
  @override
  String? get note;
  @override
  String? get createdOn;
  @override
  @JsonKey(ignore: true)
  _$PaymentHistoryCopyWith<_PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
