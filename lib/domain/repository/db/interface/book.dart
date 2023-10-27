import 'package:rekordi/domain/entity/book.dart';

/// 記録帳のソート順
enum BookOrder {
  titleAsc,
  titleDesc,
  createdAtAsc,
  createdAtDesc,
}

/// 記録帳用のDBリポジトリ
abstract interface class IBookDbRepository {
  /// 全件取得して監視
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc});

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<BookEntity?> watchOneOrNull(int bookId);
}
