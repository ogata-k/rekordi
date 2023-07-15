import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rekordi/domain/domain_infra/local_database.dart';
import 'package:rekordi/util/error.dart';

part 'database.g.dart';

typedef Migration = Future<void> Function(Migrator m);

final Map<int, Migration> _incrementMigration = {};
final Map<int, Migration> _rollbackMigration = {};

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
          if (from == to) {
            throw UnreachableError(
              description:
                  // ignore: lines_longer_than_80_chars
                  'This onUpgrade called when from version not equal to to version',
            );
          }

          if (from < to) {
            int v = from;
            while (v <= to) {
              final Migration? migration = _incrementMigration[v];
              if (migration != null) {
                await migration(m);
              }
              v++;
            }
          } else {
            int v = from;
            while (v >= to) {
              final Migration? migration = _rollbackMigration[v];
              if (migration != null) {
                await migration(m);
              }
              v--;
            }
          }
        },
        beforeOpen: (details) async {
          // your existing beforeOpen callback, enable foreign keys, etc.

          if (kDebugMode) {
            // This check pulls in a fair amount of code that's not needed
            // anywhere else, so we recommend only doing it in debug builds.
            await validateDatabaseSchema();
          }
        },
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
