import 'package:drift/drift.dart';
import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db_repository/book.dart';
import 'package:rekordi/infra/local_db/database.dart';
import 'package:rekordi/infra/local_db/table/books.dart';
import 'package:rekordi/util/exception.dart';

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

class DbRepositoryBooksDao extends BookDbRepository {
  DbRepositoryBooksDao(this._dao);

  final BooksDao _dao;

  @override
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc}) =>
      _dao.watchAll(order: order).map(
            (items) => items.map((e) => e.toEntity()).toList(),
          );

  @override
  Stream<BookEntity> watchOneOrFail(int bookId) =>
      _dao.watchOneOrFail(bookId).map((e) => e.toEntity());

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

  /// 指定したIDの記録帳を一件取得して監視。
  /// 見つからなかったらエラー
  Stream<Book> watchOneOrFail(int bookId) {
    return (select(books)..where((t) => t.bookId.equals(bookId)))
        .watchSingleOrNull()
        .map(
      (v) {
        if (v == null) {
          throw NotFoundException();
        }
        return v;
      },
    );
  }

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<Book?> watchOneOrNull(int bookId) {
    return (select(books)..where((t) => t.bookId.equals(bookId)))
        .watchSingleOrNull();
  }
}
