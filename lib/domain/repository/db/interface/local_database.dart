import 'package:rekordi/domain/repository/db/interface/book.dart';
import 'package:rekordi/domain/repository/db/interface/footprint.dart';

/// アプリで使うデータベースが備えていてほしい機能
abstract interface class ILocalDatabase {
  // @todo 各データにアクセスできるオブジェクトを返すことのできるようにする
  /// DBとのコネクションを閉じる＋リソースとの紐づけを解除
  Future<void> close();

  IBookDbRepository get bookDbRepository;

  IFootprintDbRepository get footprintDbRepository;
}
