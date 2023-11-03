import 'package:rekordi/domain/entity/footprint.dart';

/// 記録のソート順
enum FootprintOrder {
  createdAtAsc,
  createdAtDesc,
}

/// 記録用のDBリポジトリ
// ignore: one_member_abstracts
abstract class IFootprintDbRepository {
  /// 指定した日にちの記録一覧
  Stream<List<FootprintEntity>> watchAllAtRecordDate(
    int bookId,
    DateTime recordDate, {
    FootprintOrder order = FootprintOrder.createdAtAsc,
  });
}
