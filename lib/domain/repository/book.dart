import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db_repository/book.dart';

/// 記録帳のソート順
enum BookOrder {
  titleAsc,
  titleDesc,
  createdAtAsc,
  createdAtDesc,
}

/// 記録帳用のリポジトリ
class BookRepository {
  BookRepository({required BookDbRepository dbRepository}) : _db = dbRepository;

  final BookDbRepository _db;

  /// 全件取得して監視
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc}) =>
      _db.watchAll(order: order);

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<BookEntity?> watchOneOrNull(int bookId) => _db.watchOneOrNull(bookId);
}
