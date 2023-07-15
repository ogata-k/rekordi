import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rekordi/domain/entity/attachment.dart';

part 'footprint.freezed.dart';

/// 記録一つ分のエンティティ
@freezed
class FootprintEntity with _$FootprintEntity {
  const factory FootprintEntity({
    required int footprintId,
    required int bookId,
    required String message,
    required List<AttachmentEntity> attachments,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FootprintEntity;

  /// Private Constructor
  /// この中で独自のメソッドを定義するにはこれがないとエラーになる
  const FootprintEntity._();
}
