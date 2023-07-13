import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

/// 記録簿のグループ単位である本のエンティティ
@freezed
class BookEntity with _$BookEntity {
  const factory BookEntity({
    required int bookId,
    required String title,
    required String description,
    required Color lightThemeBaseColor,
    required Color dartThemeBaseColor,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookEntity;
}
