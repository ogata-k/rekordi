import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rekordi/component/logger.dart';
import 'package:rekordi/domain/domain_infra/local_database.dart';
import 'package:rekordi/infra/local_db/schema_version.dart';
import 'package:rekordi/infra/local_db/table/attachments.dart';
import 'package:rekordi/infra/local_db/table/books.dart';
import 'package:rekordi/infra/local_db/table/footprints.dart';
import 'package:rekordi/util/error.dart';

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

  @override
  Future<void> close() async {
    await _instance.close();
  }
}

typedef Migration = Future<void> Function(Migrator m);

/// App Database infra
@DriftDatabase(tables: [Books, Footprints, Attachments], daos: [])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override

  /// 最終的になっていると期待するスキーマ
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        books,
        footprints,
        Index(
          'footprints_book_id_index',
          // ignore: lines_longer_than_80_chars
          'CREATE INDEX footprints_book_id_index ON footprints (book_id)',
        ),
        Index(
          'footprints_record_record__date_index',
          // ignore: lines_longer_than_80_chars
          'CREATE INDEX footprints_record_date_index ON footprints (record_date)',
        ),
        attachments,
        Index(
          'attachments_footprint_id_index',
          // ignore: lines_longer_than_80_chars
          'CREATE INDEX attachments_footprint_id_index ON attachments (footprint_id)',
        ),
        Index(
          'attachments_position_index',
          // ignore: lines_longer_than_80_chars
          'CREATE INDEX attachments_position_index ON attachments (position)',
        ),
      ];

  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        logger().info('OnCreate DB', {});
        // 最終的な状態をもとに一括作成
        for (final entity in allSchemaEntities) {
          await m.create(entity);
        }
      },
      onUpgrade: (Migrator m, int from, int to) async {
        logger().info('OnUpgrade DB', {'from': from, 'to': to});
        if (from == to) {
          throw UnreachableError(
            description:
                // ignore: lines_longer_than_80_chars
                'This onUpgrade called when from version not equal to to version',
          );
        }

        await _migrate(m, from, to);
      },
      beforeOpen: (details) async {
        // your existing beforeOpen callback, enable foreign keys, etc.
        await customStatement('PRAGMA foreign_keys = OFF');

        if (kDebugMode) {
          // This check pulls in a fair amount of code that's not needed
          // anywhere else, so we recommend only doing it in debug builds.
          await validateDatabaseSchema();
        }
      },
    );
  }

  /// 変化したバージョン情報をもとにマイグレーションを実行する
  Future<void> _migrate(Migrator m, int from, int to) async {
    if (from == to) {
      // マイグレーションの必要なし
      return;
    }

    if (from < to) {
      final upgrade = stepByStep(
        from0To1: (m, schema) async {
          const int targetVersion = 0;
          await _doMigrateStep(m, targetVersion, from, to, (m) async {
            await m.createTable(schema.books);

            await m.createTable(schema.footprints);
            await m.createIndex(
              Index(
                'footprints_book_id_index',
                // ignore: lines_longer_than_80_chars
                'CREATE INDEX footprints_book_id_index ON footprints (book_id)',
              ),
            );
            await m.createIndex(
              Index(
                'footprints_record_date_index',
                // ignore: lines_longer_than_80_chars
                'CREATE INDEX footprints_date_index ON footprints (record_date)',
              ),
            );

            await m.createTable(schema.attachments);
            await m.createIndex(
              Index(
                'attachments_footprint_id_index',
                // ignore: lines_longer_than_80_chars
                'CREATE INDEX attachments_footprint_id_index ON attachments (footprint_id)',
              ),
            );
            await m.createIndex(
              Index(
                'attachments_position_index',
                // ignore: lines_longer_than_80_chars
                'CREATE INDEX attachments_position_index ON attachments (position)',
              ),
            );
          });
        },
      );

      return await upgrade(m, from, to);
    } else {
      int targetVersion = from;
      while (targetVersion >= to + 1) {
        switch (targetVersion) {
          case 1:
            // from1To0
            await _doMigrateStep(m, targetVersion, from, to, (m) async {
              await m.deleteTable('books');
              await m.deleteTable('footprints');
              await m.deleteTable('attachments');
              return;
            });
        }
        targetVersion--;
      }

      return;
    }
  }

  /// マイグレーションを一つ進める
  Future<void> _doMigrateStep(
    Migrator m,
    int current,
    int from,
    int to,
    Migration migration,
  ) async {
    if (from == to) {
      return;
    }

    if (from < to) {
      logger().info(
        'increment migrate',
        {'current': current, 'from': from, 'to': to},
      );
      await migration(m);
      return;
    }

    if (to < from) {
      logger().info(
        'decrement migrate',
        {'current': current, 'from': from, 'to': to},
      );
      await migration(m);
      return;
    }
  }
}

/// DBと接続する
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
