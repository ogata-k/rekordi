import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';

/// 記録に添付する画像のエンティティ
@freezed
class AttachmentEntity with _$AttachmentEntity {
  const factory AttachmentEntity({
    required int attachmentId,
    required int footprintId,
    required String filename,
    required String filepath,
    required DateTime storedAt,
  }) = _AttachmentEntity;

  /// Private Constructor
  /// この中で独自のメソッドを定義するにはこれがないとエラーになる
  const AttachmentEntity._();
}
