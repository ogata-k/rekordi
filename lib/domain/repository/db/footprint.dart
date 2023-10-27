import 'package:rekordi/domain/entity/footprint.dart';
import 'package:rekordi/domain/repository/db/interface/footprint.dart';

export 'package:rekordi/domain/repository/db/interface/footprint.dart'
    show FootprintOrder;

/// 記録用のリポジトリ
class FootprintRepository {
  FootprintRepository({required FootprintDbRepository dbRepository})
      : _db = dbRepository;

  final FootprintDbRepository _db;

  /// 指定した日にちの記録一覧
  Stream<List<FootprintEntity>> watchAllAtRecordDate(
    int bookId,
    DateTime recordDate, {
    FootprintOrder order = FootprintOrder.createdAtAsc,
  }) =>
      _db.watchAllAtRecordDate(bookId, recordDate, order: order);
}
