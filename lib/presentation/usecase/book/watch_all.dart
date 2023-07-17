import 'package:rekordi/domain/entity/book.dart';
import 'package:rekordi/domain/repository/book.dart';
import 'package:rekordi/presentation/usecase/base_usecase.dart';

/// 記録帳を全件取得して監視するユースケース
class WatchAllUseCase extends BaseUsecase {
  WatchAllUseCase(this.repository);

  final BookRepository repository;

  Stream<List<BookEntity>> call({BookOrder order = BookOrder.titleAsc}) =>
      repository.watchAll(order: order);
}
