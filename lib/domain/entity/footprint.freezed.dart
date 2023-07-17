// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'footprint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FootprintEntity {
  int get footprintId => throw _privateConstructorUsedError;

  int get bookId => throw _privateConstructorUsedError;

  String get message => throw _privateConstructorUsedError;

  DateTime get recordDate => throw _privateConstructorUsedError;

  List<AttachmentEntity> get attachments => throw _privateConstructorUsedError;

  DateTime get createdAt => throw _privateConstructorUsedError;

  DateTime get updatedAt => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int footprintId,
            int bookId,
            String message,
            DateTime recordDate,
            List<AttachmentEntity> attachments,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int footprintId,
            int bookId,
            String message,
            DateTime recordDate,
            List<AttachmentEntity> attachments,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FootprintEntity value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FootprintEntity value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FootprintEntity value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FootprintEntityCopyWith<FootprintEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FootprintEntityCopyWith<$Res> {
  factory $FootprintEntityCopyWith(
          FootprintEntity value, $Res Function(FootprintEntity) then) =
      _$FootprintEntityCopyWithImpl<$Res, FootprintEntity>;

  @useResult
  $Res call(
      {int footprintId,
      int bookId,
      String message,
      DateTime recordDate,
      List<AttachmentEntity> attachments,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$FootprintEntityCopyWithImpl<$Res, $Val extends FootprintEntity>
    implements $FootprintEntityCopyWith<$Res> {
  _$FootprintEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? footprintId = null,
    Object? bookId = null,
    Object? message = null,
    Object? recordDate = null,
    Object? attachments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      footprintId: null == footprintId
          ? _value.footprintId
          : footprintId // ignore: cast_nullable_to_non_nullable
              as int,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentEntity>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FootprintEntityCopyWith<$Res>
    implements $FootprintEntityCopyWith<$Res> {
  factory _$$_FootprintEntityCopyWith(
          _$_FootprintEntity value, $Res Function(_$_FootprintEntity) then) =
      __$$_FootprintEntityCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {int footprintId,
      int bookId,
      String message,
      DateTime recordDate,
      List<AttachmentEntity> attachments,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$_FootprintEntityCopyWithImpl<$Res>
    extends _$FootprintEntityCopyWithImpl<$Res, _$_FootprintEntity>
    implements _$$_FootprintEntityCopyWith<$Res> {
  __$$_FootprintEntityCopyWithImpl(
      _$_FootprintEntity _value, $Res Function(_$_FootprintEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? footprintId = null,
    Object? bookId = null,
    Object? message = null,
    Object? recordDate = null,
    Object? attachments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_FootprintEntity(
      footprintId: null == footprintId
          ? _value.footprintId
          : footprintId // ignore: cast_nullable_to_non_nullable
              as int,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentEntity>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_FootprintEntity extends _FootprintEntity {
  const _$_FootprintEntity(
      {required this.footprintId,
      required this.bookId,
      required this.message,
      required this.recordDate,
      required final List<AttachmentEntity> attachments,
      required this.createdAt,
      required this.updatedAt})
      : _attachments = attachments,
        super._();

  @override
  final int footprintId;
  @override
  final int bookId;
  @override
  final String message;
  @override
  final DateTime recordDate;
  final List<AttachmentEntity> _attachments;

  @override
  List<AttachmentEntity> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'FootprintEntity(footprintId: $footprintId, bookId: $bookId, message: $message, recordDate: $recordDate, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FootprintEntity &&
            (identical(other.footprintId, footprintId) ||
                other.footprintId == footprintId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      footprintId,
      bookId,
      message,
      recordDate,
      const DeepCollectionEquality().hash(_attachments),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FootprintEntityCopyWith<_$_FootprintEntity> get copyWith =>
      __$$_FootprintEntityCopyWithImpl<_$_FootprintEntity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int footprintId,
            int bookId,
            String message,
            DateTime recordDate,
            List<AttachmentEntity> attachments,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    return $default(footprintId, bookId, message, recordDate, attachments,
        createdAt, updatedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int footprintId,
            int bookId,
            String message,
            DateTime recordDate,
            List<AttachmentEntity> attachments,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(footprintId, bookId, message, recordDate, attachments,
          createdAt, updatedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FootprintEntity value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FootprintEntity value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FootprintEntity value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _FootprintEntity extends FootprintEntity {
  const factory _FootprintEntity(
      {required final int footprintId,
      required final int bookId,
      required final String message,
      required final DateTime recordDate,
      required final List<AttachmentEntity> attachments,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$_FootprintEntity;

  const _FootprintEntity._() : super._();

  @override
  int get footprintId;

  @override
  int get bookId;

  @override
  String get message;

  @override
  DateTime get recordDate;

  @override
  List<AttachmentEntity> get attachments;

  @override
  DateTime get createdAt;

  @override
  DateTime get updatedAt;

  @override
  @JsonKey(ignore: true)
  _$$_FootprintEntityCopyWith<_$_FootprintEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
