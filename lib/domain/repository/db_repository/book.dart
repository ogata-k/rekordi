import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/book.dart';

export 'package:rekordi/domain/repository/book.dart' show BookOrder;

/// 記録帳用のDBリポジトリ
abstract class BookDbRepository {
  /// 全件取得して監視
  Stream<List<BookEntity>> watchAll({BookOrder order = BookOrder.titleAsc});

  /// 指定したIDの記録帳を一件取得して監視。
  /// 見つからなかったらエラー
  Stream<BookEntity> watchOneOrFail(int bookId);

  /// 指定したIDの記録帳を一件取得して監視
  /// 見つからなかったらnull
  Stream<BookEntity?> watchOneOrNull(int bookId);
}
