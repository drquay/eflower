// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
class _$AttachmentTearOff {
  const _$AttachmentTearOff();

  _Attachment call(
      {String? id,
      String? img,
      String? name,
      required String url,
      String? thumbnail,
      User? uploadedBy,
      required String createdOn}) {
    return _Attachment(
      id: id,
      img: img,
      name: name,
      url: url,
      thumbnail: thumbnail,
      uploadedBy: uploadedBy,
      createdOn: createdOn,
    );
  }

  Attachment fromJson(Map<String, Object?> json) {
    return Attachment.fromJson(json);
  }
}

/// @nodoc
const $Attachment = _$AttachmentTearOff();

/// @nodoc
mixin _$Attachment {
  String? get id => throw _privateConstructorUsedError;
  String? get img => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  User? get uploadedBy => throw _privateConstructorUsedError;
  String get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? img,
      String? name,
      String url,
      String? thumbnail,
      User? uploadedBy,
      String createdOn});

  $UserCopyWith<$Res>? get uploadedBy;
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res> implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  final Attachment _value;
  // ignore: unused_field
  final $Res Function(Attachment) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? img = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? thumbnail = freezed,
    Object? uploadedBy = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: uploadedBy == freezed
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as User?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $UserCopyWith<$Res>? get uploadedBy {
    if (_value.uploadedBy == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.uploadedBy!, (value) {
      return _then(_value.copyWith(uploadedBy: value));
    });
  }
}

/// @nodoc
abstract class _$AttachmentCopyWith<$Res> implements $AttachmentCopyWith<$Res> {
  factory _$AttachmentCopyWith(
          _Attachment value, $Res Function(_Attachment) then) =
      __$AttachmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? img,
      String? name,
      String url,
      String? thumbnail,
      User? uploadedBy,
      String createdOn});

  @override
  $UserCopyWith<$Res>? get uploadedBy;
}

/// @nodoc
class __$AttachmentCopyWithImpl<$Res> extends _$AttachmentCopyWithImpl<$Res>
    implements _$AttachmentCopyWith<$Res> {
  __$AttachmentCopyWithImpl(
      _Attachment _value, $Res Function(_Attachment) _then)
      : super(_value, (v) => _then(v as _Attachment));

  @override
  _Attachment get _value => super._value as _Attachment;

  @override
  $Res call({
    Object? id = freezed,
    Object? img = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? thumbnail = freezed,
    Object? uploadedBy = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_Attachment(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: uploadedBy == freezed
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as User?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Attachment extends _Attachment {
  const _$_Attachment(
      {this.id,
      this.img,
      this.name,
      required this.url,
      this.thumbnail,
      this.uploadedBy,
      required this.createdOn})
      : super._();

  factory _$_Attachment.fromJson(Map<String, dynamic> json) =>
      _$$_AttachmentFromJson(json);

  @override
  final String? id;
  @override
  final String? img;
  @override
  final String? name;
  @override
  final String url;
  @override
  final String? thumbnail;
  @override
  final User? uploadedBy;
  @override
  final String createdOn;

  @override
  String toString() {
    return 'Attachment(id: $id, img: $img, name: $name, url: $url, thumbnail: $thumbnail, uploadedBy: $uploadedBy, createdOn: $createdOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Attachment &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.img, img) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail) &&
            const DeepCollectionEquality()
                .equals(other.uploadedBy, uploadedBy) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(img),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(thumbnail),
      const DeepCollectionEquality().hash(uploadedBy),
      const DeepCollectionEquality().hash(createdOn));

  @JsonKey(ignore: true)
  @override
  _$AttachmentCopyWith<_Attachment> get copyWith =>
      __$AttachmentCopyWithImpl<_Attachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttachmentToJson(this);
  }
}

abstract class _Attachment extends Attachment {
  const factory _Attachment(
      {String? id,
      String? img,
      String? name,
      required String url,
      String? thumbnail,
      User? uploadedBy,
      required String createdOn}) = _$_Attachment;
  const _Attachment._() : super._();

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$_Attachment.fromJson;

  @override
  String? get id;
  @override
  String? get img;
  @override
  String? get name;
  @override
  String get url;
  @override
  String? get thumbnail;
  @override
  User? get uploadedBy;
  @override
  String get createdOn;
  @override
  @JsonKey(ignore: true)
  _$AttachmentCopyWith<_Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}
