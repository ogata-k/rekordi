import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/db/book.dart';
import 'package:rekordi/presentation/usecase/usecase.dart';

/// 記録帳を全件取得して監視するユースケース
class WatchAllBookUseCase extends IUsecase {
  WatchAllBookUseCase(this.repository);

  final BookDbRepository repository;

  Stream<List<BookEntity>> call({BookOrder order = BookOrder.titleAsc}) =>
      repository.watchAll(order: order);
}
