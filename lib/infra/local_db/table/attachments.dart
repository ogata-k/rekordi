import 'package:drift/drift.dart';

/// attachmentsテーブル：添付ファイル
/// 記録(footprints)における添付ファイルのこと
@DataClassName('Attachment')
class Attachments extends Table {
  @override
  String? get tableName => 'attachments';

  IntColumn get attachmentId => integer().autoIncrement()();

  IntColumn get footprintId => integer()();

  TextColumn get filename => text().withLength(min: 1, max: 255)();

  TextColumn get filepath => text().withLength(min: 1)();

  IntColumn get position => integer()();

  DateTimeColumn get storedAt => dateTime()();
}
