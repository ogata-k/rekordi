import 'package:drift/drift.dart';

/// footprintsテーブル：記録
/// 記録帳(books)に所属する記録のこと
@DataClassName('Footprint')
class Footprints extends Table {
  @override
  String? get tableName => 'footprints';

  @override
  Set<Column<Object>>? get primaryKey => {footprintId};

  IntColumn get footprintId => integer().autoIncrement()();

  IntColumn get bookId => integer()();

  TextColumn get message => text()();

  DateTimeColumn get recordDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
