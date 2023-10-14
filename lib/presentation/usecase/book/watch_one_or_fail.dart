import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/book.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';
import 'package:rekordi/util/exception.dart';

/// 指定したIDの記録帳を一件取得して監視するユースケース
/// 見つからなかったらエラー
class WatchOneBookOrFailUseCase extends BaseUsecase {
  WatchOneBookOrFailUseCase(this.repository);

  final BookRepository repository;

  Stream<BookEntity> call(int bookId) =>
      repository.watchOneOrNull(bookId).map((e) {
        if (e == null) {
          throw NotFoundException();
        }

        return e;
      });
}
