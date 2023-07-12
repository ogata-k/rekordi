import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rekordi/domain/domain_infra/local_database.dart';

part 'database.g.dart';

/// infraのLocalDatabase実装
class InfraLocalDatabase extends LocalDatabase {
  InfraLocalDatabase(this._instance);

  /// 自身のインスタンスを返却する
  factory InfraLocalDatabase.buildInstance() {
    final Database instance = Database();
    return InfraLocalDatabase(instance);
  }

  final Database _instance;
}

/// App Database infra
@DriftDatabase(tables: [], daos: [])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 0;

  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: false);

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll(); // default
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // @todo upgrade migration
        },
        beforeOpen: (OpeningDetails details) async {},
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
