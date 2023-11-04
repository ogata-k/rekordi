// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AttachmentEntity {
  int get attachmentId => throw _privateConstructorUsedError;
  int get footprintId => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get filepath => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get storedAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int attachmentId, int footprintId, String filename,
            String filepath, int position, DateTime storedAt)
        $default,
  ) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int attachmentId, int footprintId, String filename,
            String filepath, int position, DateTime storedAt)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AttachmentEntity value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AttachmentEntity value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AttachmentEntity value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttachmentEntityCopyWith<AttachmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentEntityCopyWith<$Res> {
  factory $AttachmentEntityCopyWith(
          AttachmentEntity value, $Res Function(AttachmentEntity) then) =
      _$AttachmentEntityCopyWithImpl<$Res, AttachmentEntity>;
  @useResult
  $Res call(
      {int attachmentId,
      int footprintId,
      String filename,
      String filepath,
      int position,
      DateTime storedAt});
}

/// @nodoc
class _$AttachmentEntityCopyWithImpl<$Res, $Val extends AttachmentEntity>
    implements $AttachmentEntityCopyWith<$Res> {
  _$AttachmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachmentId = null,
    Object? footprintId = null,
    Object? filename = null,
    Object? filepath = null,
    Object? position = null,
    Object? storedAt = null,
  }) {
    return _then(_value.copyWith(
      attachmentId: null == attachmentId
          ? _value.attachmentId
          : attachmentId // ignore: cast_nullable_to_non_nullable
              as int,
      footprintId: null == footprintId
          ? _value.footprintId
          : footprintId // ignore: cast_nullable_to_non_nullable
              as int,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      filepath: null == filepath
          ? _value.filepath
          : filepath // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      storedAt: null == storedAt
          ? _value.storedAt
          : storedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentEntityImplCopyWith<$Res>
    implements $AttachmentEntityCopyWith<$Res> {
  factory _$$AttachmentEntityImplCopyWith(_$AttachmentEntityImpl value,
          $Res Function(_$AttachmentEntityImpl) then) =
      __$$AttachmentEntityImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {int attachmentId,
      int footprintId,
      String filename,
      String filepath,
      int position,
      DateTime storedAt});
}

/// @nodoc
class __$$AttachmentEntityImplCopyWithImpl<$Res>
    extends _$AttachmentEntityCopyWithImpl<$Res, _$AttachmentEntityImpl>
    implements _$$AttachmentEntityImplCopyWith<$Res> {
  __$$AttachmentEntityImplCopyWithImpl(_$AttachmentEntityImpl _value,
      $Res Function(_$AttachmentEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachmentId = null,
    Object? footprintId = null,
    Object? filename = null,
    Object? filepath = null,
    Object? position = null,
    Object? storedAt = null,
  }) {
    return _then(_$AttachmentEntityImpl(
      attachmentId: null == attachmentId
          ? _value.attachmentId
          : attachmentId // ignore: cast_nullable_to_non_nullable
              as int,
      footprintId: null == footprintId
          ? _value.footprintId
          : footprintId // ignore: cast_nullable_to_non_nullable
              as int,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      filepath: null == filepath
          ? _value.filepath
          : filepath // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      storedAt: null == storedAt
          ? _value.storedAt
          : storedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AttachmentEntityImpl extends _AttachmentEntity {
  const _$AttachmentEntityImpl(
      {required this.attachmentId,
      required this.footprintId,
      required this.filename,
      required this.filepath,
      required this.position,
      required this.storedAt})
      : super._();

  @override
  final int attachmentId;
  @override
  final int footprintId;
  @override
  final String filename;
  @override
  final String filepath;
  @override
  final int position;
  @override
  final DateTime storedAt;

  @override
  String toString() {
    return 'AttachmentEntity(attachmentId: $attachmentId, footprintId: $footprintId, filename: $filename, filepath: $filepath, position: $position, storedAt: $storedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentEntityImpl &&
            (identical(other.attachmentId, attachmentId) ||
                other.attachmentId == attachmentId) &&
            (identical(other.footprintId, footprintId) ||
                other.footprintId == footprintId) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.filepath, filepath) ||
                other.filepath == filepath) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.storedAt, storedAt) ||
                other.storedAt == storedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attachmentId, footprintId,
      filename, filepath, position, storedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      __$$AttachmentEntityImplCopyWithImpl<_$AttachmentEntityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int attachmentId, int footprintId, String filename,
            String filepath, int position, DateTime storedAt)
        $default,
  ) {
    return $default(
        attachmentId, footprintId, filename, filepath, position, storedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int attachmentId, int footprintId, String filename,
            String filepath, int position, DateTime storedAt)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          attachmentId, footprintId, filename, filepath, position, storedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AttachmentEntity value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AttachmentEntity value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AttachmentEntity value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AttachmentEntity extends AttachmentEntity {
  const factory _AttachmentEntity(
      {required final int attachmentId,
      required final int footprintId,
      required final String filename,
      required final String filepath,
      required final int position,
      required final DateTime storedAt}) = _$AttachmentEntityImpl;
  const _AttachmentEntity._() : super._();

  @override
  int get attachmentId;
  @override
  int get footprintId;
  @override
  String get filename;
  @override
  String get filepath;
  @override
  int get position;

  @override
  DateTime get storedAt;

  @override
  @JsonKey(ignore: true)
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
