import 'package:rekordi/domain/repository/db_repository/book.dart';
import 'package:rekordi/domain/repository/db_repository/footprint.dart';

/// アプリで使うデータベースが備えていてほしい機能
abstract class LocalDatabase {
  // @todo 各データにアクセスできるオブジェクトを返すことのできるようにする
  /// DBとのコネクションを閉じる＋リソースとの紐づけを解除
  Future<void> close();

  BookDbRepository get bookDbRepository;

  FootprintDbRepository get footprintDbRepository;
}
