import 'package:drift/drift.dart';
import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/interface/book.dart';
import 'package:rekordi/infra/repository/db/database.dart';
import 'package:rekordi/infra/repository/db/table/books.dart';

// 自動生成でも変換後の型を使えるようにexportする
export 'package:rekordi/infra/repository/db/type_converter.dart';

part 'books.g.dart';

extension on Book {
  BookEntity toEntity() => BookEntity(
        bookId: bookId,
        title: title,
        description: description,
        lightThemeColor: lightThemeColor,
        dartThemeColor: darkThemeColor,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

class DbRepositoryBooksDao implements BookDbRepository {
  DbRepositoryBooksDao(this._dao);

  final BooksDao _dao;

  @override
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc}) =>
      _dao.watchAll(order: order).map(
            (items) => items.map((e) => e.toEntity()).toList(),
          );

  @override
  Stream<BookEntity?> watchOneOrNull(int bookId) =>
      _dao.watchOneOrNull(bookId).map((e) => e?.toEntity());
}

/// 記録帳のDAO
@DriftAccessor(tables: [Books])
class BooksDao extends DatabaseAccessor<Database> with _$BooksDaoMixin {
  BooksDao(Database db) : super(db);

  /// 全件取得して監視
  Stream<List<Book>> watchAll({BookOrder order = BookOrder.titleAsc}) {
    return (select(books)
          ..orderBy([
            (u) {
              switch (order) {
                case BookOrder.titleAsc:
                  return OrderingTerm(
                    expression: u.title,
                    mode: OrderingMode.asc,
                  );
                case BookOrder.titleDesc:
                  return OrderingTerm(
                    expression: u.title,
                    mode: OrderingMode.desc,
                  );
                case BookOrder.createdAtAsc:
                  return OrderingTerm(
                    expression: u.createdAt,
                    mode: OrderingMode.asc,
                  );
                case BookOrder.createdAtDesc:
                  return OrderingTerm(
                    expression: u.createdAt,
                    mode: OrderingMode.desc,
                  );
              }
            }
          ]))
        .watch();
  }

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<Book?> watchOneOrNull(int bookId) {
    return (select(books)..where((t) => t.bookId.equals(bookId)))
        .watchSingleOrNull();
  }
}
