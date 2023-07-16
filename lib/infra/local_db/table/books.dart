import 'package:drift/drift.dart';

/// booksテーブル：記録帳
/// 記録(footprints)の所属する記録帳のこと
@DataClassName('Book')
class Books extends Table {
  @override
  String? get tableName => 'books';

  @override
  Set<Column<Object>>? get primaryKey => {bookId};

  IntColumn get bookId => integer().autoIncrement()();

  TextColumn get title => text().unique().withLength(min: 1, max: 50)();

  TextColumn get description => text().withLength(max: 500)();

  /// #FFAABBCCの形の色データ
  TextColumn get lightThemeColor => text().withLength(min: 9, max: 9)();

  /// #FFAABBCCの形の色データ
  TextColumn get darkThemeColor => text().withLength(min: 9, max: 9)();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
