import 'package:drift/drift.dart';
import 'package:rekordi/domain/entity/attachment.dart';
import 'package:rekordi/domain/entity/footprint.dart';
import 'package:rekordi/domain/repository/db_repository/footprint.dart';
import 'package:rekordi/infra/local_db/database.dart';
import 'package:rekordi/infra/local_db/query_util.dart';
import 'package:rekordi/infra/local_db/table/attachments.dart';
import 'package:rekordi/infra/local_db/table/footprints.dart';

part 'footprints.g.dart';

extension on FootprintWithAttachments {
  FootprintEntity toEntity() => FootprintEntity(
        footprintId: footprint.footprintId,
        bookId: footprint.bookId,
        message: footprint.message,
        recordDate: footprint.recordDate,
        attachments: attachments.map((e) => e.toEntity()).toList(),
        createdAt: footprint.createdAt,
        updatedAt: footprint.updatedAt,
      );
}

extension on Attachment {
  AttachmentEntity toEntity() => AttachmentEntity(
        attachmentId: attachmentId,
        footprintId: footprintId,
        filename: filename,
        filepath: filepath,
        position: position,
        storedAt: storedAt,
      );
}

class DbRepositoryFootprintsDao extends FootprintDbRepository {
  DbRepositoryFootprintsDao(this._dao);

  final FootprintsDao _dao;

  @override
  Stream<List<FootprintEntity>> watchAllAtRecordDate(
    int bookId,
    DateTime recordDate, {
    FootprintOrder order = FootprintOrder.createdAtAsc,
  }) =>
      _dao
          .watchAllAtRecordDate(bookId, recordDate)
          .map((items) => items.map((e) => e.toEntity()).toList());
}

/// 添付ファイル付き記録
class FootprintWithAttachments {
  FootprintWithAttachments(this.footprint, this.attachments);

  final Footprint footprint;
  final List<Attachment> attachments;
}

/// 記録のDAO
@DriftAccessor(tables: [Footprints, Attachments])
class FootprintsDao extends DatabaseAccessor<Database>
    with _$FootprintsDaoMixin {
  FootprintsDao(Database db) : super(db);

  /// 指定した日にちの記録一覧
  Stream<List<FootprintWithAttachments>> watchAllAtRecordDate(
    int bookId,
    DateTime recordDate, {
    FootprintOrder order = FootprintOrder.createdAtAsc,
  }) {
    final Stream<List<Footprint>> footprintItems = (select(footprints)
          ..where(
            (t) =>
                t.bookId.equals(bookId) &
                QueryUtil().equalDate(t.recordDate, recordDate),
          )
          ..orderBy([
            (u) {
              switch (order) {
                case FootprintOrder.createdAtAsc:
                  return OrderingTerm(
                    expression: u.createdAt,
                    mode: OrderingMode.asc,
                  );
                case FootprintOrder.createdAtDesc:
                  return OrderingTerm(
                    expression: u.createdAt,
                    mode: OrderingMode.desc,
                  );
              }
            }
          ]))
        .watch();

    return footprintItems.asyncMap((items) async {
      final List<FootprintWithAttachments> result = [];
      for (final item in items) {
        final List<Attachment> itemAttachments = await (select(attachments)
              ..where((t) => t.footprintId.equals(item.footprintId))
              ..orderBy([
                (u) => OrderingTerm(
                      expression: u.position,
                      mode: OrderingMode.asc,
                    ),
              ]))
            .get();
        result.add(FootprintWithAttachments(item, itemAttachments));
      }

      return result;
    });
  }
}
