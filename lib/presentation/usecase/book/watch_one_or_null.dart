import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';

/// 指定したIDの記録帳を一件取得して監視するユースケース
/// 見つからなかったらnull
class WatchOneBookOrNullUseCase extends IUsecase {
  WatchOneBookOrNullUseCase(this.repository);

  final BookDbRepository repository;

  Stream<BookEntity?> call(int bookId) => repository.watchOneOrNull(bookId);
}
