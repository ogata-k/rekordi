import 'package:drift/drift.dart';
import 'package:rekordi/infra/local_db/type_converter.dart';

/// booksテーブル：記録帳
/// 記録(footprints)の所属する記録帳のこと
@DataClassName('Book')
class Books extends Table {
  @override
  String? get tableName => 'books';

  IntColumn get bookId => integer().autoIncrement()();

  TextColumn get title => text().unique().withLength(min: 1, max: 50)();

  TextColumn get description => text().withLength(max: 500)();

  /// FFAABBCCの形の色データ
  IntColumn get lightThemeColor =>
      integer().map<Color>(const ColorConverter())();

  /// FFAABBCCの形の色データ
  IntColumn get darkThemeColor =>
      integer().map<Color>(const ColorConverter())();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
