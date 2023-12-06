// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'deposit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Deposit _$DepositFromJson(Map<String, dynamic> json) {
  return _Deposit.fromJson(json);
}

/// @nodoc
class _$DepositTearOff {
  const _$DepositTearOff();

  _Deposit call(
      {String? id,
      double? amount,
      List<Attachment>? attachments,
      String? moneyKeeperId,
      String? paymentReason,
      String? note,
      String? type,
      String? createdOn}) {
    return _Deposit(
      id: id,
      amount: amount,
      attachments: attachments,
      moneyKeeperId: moneyKeeperId,
      paymentReason: paymentReason,
      note: note,
      type: type,
      createdOn: createdOn,
    );
  }

  Deposit fromJson(Map<String, Object?> json) {
    return Deposit.fromJson(json);
  }
}

/// @nodoc
const $Deposit = _$DepositTearOff();

/// @nodoc
mixin _$Deposit {
  String? get id => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  List<Attachment>? get attachments => throw _privateConstructorUsedError;
  String? get moneyKeeperId => throw _privateConstructorUsedError;
  String? get paymentReason => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepositCopyWith<Deposit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepositCopyWith<$Res> {
  factory $DepositCopyWith(Deposit value, $Res Function(Deposit) then) =
      _$DepositCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      double? amount,
      List<Attachment>? attachments,
      String? moneyKeeperId,
      String? paymentReason,
      String? note,
      String? type,
      String? createdOn});
}

/// @nodoc
class _$DepositCopyWithImpl<$Res> implements $DepositCopyWith<$Res> {
  _$DepositCopyWithImpl(this._value, this._then);

  final Deposit _value;
  // ignore: unused_field
  final $Res Function(Deposit) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? attachments = freezed,
    Object? moneyKeeperId = freezed,
    Object? paymentReason = freezed,
    Object? note = freezed,
    Object? type = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      moneyKeeperId: moneyKeeperId == freezed
          ? _value.moneyKeeperId
          : moneyKeeperId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentReason: paymentReason == freezed
          ? _value.paymentReason
          : paymentReason // ignore: cast_nullable_to_non_nullable
              as String?,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$DepositCopyWith<$Res> implements $DepositCopyWith<$Res> {
  factory _$DepositCopyWith(_Deposit value, $Res Function(_Deposit) then) =
      __$DepositCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      double? amount,
      List<Attachment>? attachments,
      String? moneyKeeperId,
      String? paymentReason,
      String? note,
      String? type,
      String? createdOn});
}

/// @nodoc
class __$DepositCopyWithImpl<$Res> extends _$DepositCopyWithImpl<$Res>
    implements _$DepositCopyWith<$Res> {
  __$DepositCopyWithImpl(_Deposit _value, $Res Function(_Deposit) _then)
      : super(_value, (v) => _then(v as _Deposit));

  @override
  _Deposit get _value => super._value as _Deposit;

  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? attachments = freezed,
    Object? moneyKeeperId = freezed,
    Object? paymentReason = freezed,
    Object? note = freezed,
    Object? type = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_Deposit(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      attachments: attachments == freezed
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      moneyKeeperId: moneyKeeperId == freezed
          ? _value.moneyKeeperId
          : moneyKeeperId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentReason: paymentReason == freezed
          ? _value.paymentReason
          : paymentReason // ignore: cast_nullable_to_non_nullable
              as String?,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
class _$_Deposit extends _Deposit {
  const _$_Deposit(
      {this.id,
      this.amount,
      this.attachments,
      this.moneyKeeperId,
      this.paymentReason,
      this.note,
      this.type,
      this.createdOn})
      : super._();

  factory _$_Deposit.fromJson(Map<String, dynamic> json) =>
      _$$_DepositFromJson(json);

  @override
  final String? id;
  @override
  final double? amount;
  @override
  final List<Attachment>? attachments;
  @override
  final String? moneyKeeperId;
  @override
  final String? paymentReason;
  @override
  final String? note;
  @override
  final String? type;
  @override
  final String? createdOn;

  @override
  String toString() {
    return 'Deposit(id: $id, amount: $amount, attachments: $attachments, moneyKeeperId: $moneyKeeperId, paymentReason: $paymentReason, note: $note, type: $type, createdOn: $createdOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Deposit &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            const DeepCollectionEquality()
                .equals(other.moneyKeeperId, moneyKeeperId) &&
            const DeepCollectionEquality()
                .equals(other.paymentReason, paymentReason) &&
            const DeepCollectionEquality().equals(other.note, note) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(attachments),
      const DeepCollectionEquality().hash(moneyKeeperId),
      const DeepCollectionEquality().hash(paymentReason),
      const DeepCollectionEquality().hash(note),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(createdOn));

  @JsonKey(ignore: true)
  @override
  _$DepositCopyWith<_Deposit> get copyWith =>
      __$DepositCopyWithImpl<_Deposit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DepositToJson(this);
  }
}

abstract class _Deposit extends Deposit {
  const factory _Deposit(
      {String? id,
      double? amount,
      List<Attachment>? attachments,
      String? moneyKeeperId,
      String? paymentReason,
      String? note,
      String? type,
      String? createdOn}) = _$_Deposit;
  const _Deposit._() : super._();

  factory _Deposit.fromJson(Map<String, dynamic> json) = _$_Deposit.fromJson;

  @override
  String? get id;
  @override
  double? get amount;
  @override
  List<Attachment>? get attachments;
  @override
  String? get moneyKeeperId;
  @override
  String? get paymentReason;
  @override
  String? get note;
  @override
  String? get type;
  @override
  String? get createdOn;
  @override
  @JsonKey(ignore: true)
  _$DepositCopyWith<_Deposit> get copyWith =>
      throw _privateConstructorUsedError;
}
