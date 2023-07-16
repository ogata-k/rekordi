import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

// TODO このエンティティを返すようにDBのテーブルとDAOを作成し、LocalDBモデルがDAOを返せるようにインターフェースを修正する。DB設計についてはメモを参照

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
