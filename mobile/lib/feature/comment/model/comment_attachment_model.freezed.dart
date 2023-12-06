// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment_attachment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentAttachment _$CommentAttachmentFromJson(Map<String, dynamic> json) {
  return _CommentAttachment.fromJson(json);
}

/// @nodoc
class _$CommentAttachmentTearOff {
  const _$CommentAttachmentTearOff();

  _CommentAttachment call(
      {required String id,
      String? img,
      String? name,
      required String url,
      User? uploadedBy}) {
    return _CommentAttachment(
      id: id,
      img: img,
      name: name,
      url: url,
      uploadedBy: uploadedBy,
    );
  }

  CommentAttachment fromJson(Map<String, Object?> json) {
    return CommentAttachment.fromJson(json);
  }
}

/// @nodoc
const $CommentAttachment = _$CommentAttachmentTearOff();

/// @nodoc
mixin _$CommentAttachment {
  String get id => throw _privateConstructorUsedError;
  String? get img => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  User? get uploadedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentAttachmentCopyWith<CommentAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentAttachmentCopyWith<$Res> {
  factory $CommentAttachmentCopyWith(
          CommentAttachment value, $Res Function(CommentAttachment) then) =
      _$CommentAttachmentCopyWithImpl<$Res>;
  $Res call(
      {String id, String? img, String? name, String url, User? uploadedBy});

  $UserCopyWith<$Res>? get uploadedBy;
}

/// @nodoc
class _$CommentAttachmentCopyWithImpl<$Res>
    implements $CommentAttachmentCopyWith<$Res> {
  _$CommentAttachmentCopyWithImpl(this._value, this._then);

  final CommentAttachment _value;
  // ignore: unused_field
  final $Res Function(CommentAttachment) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? img = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? uploadedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      uploadedBy: uploadedBy == freezed
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as User?,
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
abstract class _$CommentAttachmentCopyWith<$Res>
    implements $CommentAttachmentCopyWith<$Res> {
  factory _$CommentAttachmentCopyWith(
          _CommentAttachment value, $Res Function(_CommentAttachment) then) =
      __$CommentAttachmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String? img, String? name, String url, User? uploadedBy});

  @override
  $UserCopyWith<$Res>? get uploadedBy;
}

/// @nodoc
class __$CommentAttachmentCopyWithImpl<$Res>
    extends _$CommentAttachmentCopyWithImpl<$Res>
    implements _$CommentAttachmentCopyWith<$Res> {
  __$CommentAttachmentCopyWithImpl(
      _CommentAttachment _value, $Res Function(_CommentAttachment) _then)
      : super(_value, (v) => _then(v as _CommentAttachment));

  @override
  _CommentAttachment get _value => super._value as _CommentAttachment;

  @override
  $Res call({
    Object? id = freezed,
    Object? img = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? uploadedBy = freezed,
  }) {
    return _then(_CommentAttachment(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      uploadedBy: uploadedBy == freezed
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentAttachment extends _CommentAttachment {
  const _$_CommentAttachment(
      {required this.id,
      this.img,
      this.name,
      required this.url,
      this.uploadedBy})
      : super._();

  factory _$_CommentAttachment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentAttachmentFromJson(json);

  @override
  final String id;
  @override
  final String? img;
  @override
  final String? name;
  @override
  final String url;
  @override
  final User? uploadedBy;

  @override
  String toString() {
    return 'CommentAttachment(id: $id, img: $img, name: $name, url: $url, uploadedBy: $uploadedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentAttachment &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.img, img) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.uploadedBy, uploadedBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(img),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(uploadedBy));

  @JsonKey(ignore: true)
  @override
  _$CommentAttachmentCopyWith<_CommentAttachment> get copyWith =>
      __$CommentAttachmentCopyWithImpl<_CommentAttachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentAttachmentToJson(this);
  }
}

abstract class _CommentAttachment extends CommentAttachment {
  const factory _CommentAttachment(
      {required String id,
      String? img,
      String? name,
      required String url,
      User? uploadedBy}) = _$_CommentAttachment;
  const _CommentAttachment._() : super._();

  factory _CommentAttachment.fromJson(Map<String, dynamic> json) =
      _$_CommentAttachment.fromJson;

  @override
  String get id;
  @override
  String? get img;
  @override
  String? get name;
  @override
  String get url;
  @override
  User? get uploadedBy;
  @override
  @JsonKey(ignore: true)
  _$CommentAttachmentCopyWith<_CommentAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}
