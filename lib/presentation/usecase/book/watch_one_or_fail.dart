import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';
import 'package:rekordi/util/exception/not_found_exception.dart';

/// 指定したIDの記録帳を一件取得して監視するユースケース
/// 見つからなかったらエラー
class WatchOneBookOrFailUseCase extends IUsecase {
  WatchOneBookOrFailUseCase(this.repository);

  final BookDbRepository repository;

  Stream<BookEntity> call(int bookId) =>
      repository.watchOneOrNull(bookId).map((e) {
        if (e == null) {
          throw NotFoundException();
        }

        return e;
      });
}
