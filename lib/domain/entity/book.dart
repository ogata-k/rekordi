import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

/// 記録のグループ単位である記録簿のエンティティ
@freezed
class BookEntity with _$BookEntity {
  const factory BookEntity({
    required int bookId,
    required String title,
    required String description,
    required Color lightThemeColor,
    required Color dartThemeColor,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookEntity;

  /// Private Constructor
  /// この中で独自のメソッドを定義するにはこれがないとエラーになる
  const BookEntity._();
}
