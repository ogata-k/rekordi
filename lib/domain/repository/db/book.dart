import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/interface/book.dart';

export 'package:rekordi/domain/repository/db/interface/book.dart'
    show BookOrder;

/// 記録帳用のリポジトリ
class BookDbRepository {
  BookDbRepository({required IBookDbRepository dbRepository})
      : _db = dbRepository;

  final IBookDbRepository _db;

  /// 全件取得して監視
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc}) =>
      _db.watchAll(order: order);

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<BookEntity?> watchOneOrNull(int bookId) => _db.watchOneOrNull(bookId);
}
