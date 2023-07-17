import 'package:rekordi/domain/entity/footprint.dart';
import 'package:rekordi/domain/repository/footprint.dart';

export 'package:rekordi/domain/repository/footprint.dart' show FootprintOrder;

/// 記録用のDBリポジトリ
// ignore: one_member_abstracts
abstract class FootprintDbRepository {
  /// 指定した日にちの記録一覧
  Stream<List<FootprintEntity>> watchAllAtRecordDate(
    int bookId,
    DateTime recordDate, {
    FootprintOrder order = FootprintOrder.createdAtAsc,
  });
}
