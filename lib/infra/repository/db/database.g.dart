// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lightThemeColorMeta =
      const VerificationMeta('lightThemeColor');
  @override
  late final GeneratedColumnWithTypeConverter<Color, int> lightThemeColor =
      GeneratedColumn<int>('light_theme_color', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Color>($BooksTable.$converterlightThemeColor);
  static const VerificationMeta _darkThemeColorMeta =
      const VerificationMeta('darkThemeColor');
  @override
  late final GeneratedColumnWithTypeConverter<Color, int> darkThemeColor =
      GeneratedColumn<int>('dark_theme_color', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Color>($BooksTable.$converterdarkThemeColor);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        bookId,
        title,
        description,
        lightThemeColor,
        darkThemeColor,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'books';
  @override
  String get actualTableName => 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    context.handle(_lightThemeColorMeta, const VerificationResult.success());
    context.handle(_darkThemeColorMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      lightThemeColor: $BooksTable.$converterlightThemeColor.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}light_theme_color'])!),
      darkThemeColor: $BooksTable.$converterdarkThemeColor.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}dark_theme_color'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }

  static TypeConverter<Color, int> $converterlightThemeColor =
      const ColorConverter();
  static TypeConverter<Color, int> $converterdarkThemeColor =
      const ColorConverter();
}

class Book extends DataClass implements Insertable<Book> {
  final int bookId;
  final String title;
  final String description;

  /// FFAABBCCの形の色データ
  final Color lightThemeColor;

  /// FFAABBCCの形の色データ
  final Color darkThemeColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Book(
      {required this.bookId,
      required this.title,
      required this.description,
      required this.lightThemeColor,
      required this.darkThemeColor,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_id'] = Variable<int>(bookId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    {
      final converter = $BooksTable.$converterlightThemeColor;
      map['light_theme_color'] =
          Variable<int>(converter.toSql(lightThemeColor));
    }
    {
      final converter = $BooksTable.$converterdarkThemeColor;
      map['dark_theme_color'] = Variable<int>(converter.toSql(darkThemeColor));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      bookId: Value(bookId),
      title: Value(title),
      description: Value(description),
      lightThemeColor: Value(lightThemeColor),
      darkThemeColor: Value(darkThemeColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      bookId: serializer.fromJson<int>(json['bookId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      lightThemeColor: serializer.fromJson<Color>(json['lightThemeColor']),
      darkThemeColor: serializer.fromJson<Color>(json['darkThemeColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookId': serializer.toJson<int>(bookId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'lightThemeColor': serializer.toJson<Color>(lightThemeColor),
      'darkThemeColor': serializer.toJson<Color>(darkThemeColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Book copyWith(
          {int? bookId,
          String? title,
          String? description,
          Color? lightThemeColor,
          Color? darkThemeColor,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Book(
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        description: description ?? this.description,
        lightThemeColor: lightThemeColor ?? this.lightThemeColor,
        darkThemeColor: darkThemeColor ?? this.darkThemeColor,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lightThemeColor: $lightThemeColor, ')
          ..write('darkThemeColor: $darkThemeColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bookId, title, description, lightThemeColor,
      darkThemeColor, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.bookId == this.bookId &&
          other.title == this.title &&
          other.description == this.description &&
          other.lightThemeColor == this.lightThemeColor &&
          other.darkThemeColor == this.darkThemeColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> bookId;
  final Value<String> title;
  final Value<String> description;
  final Value<Color> lightThemeColor;
  final Value<Color> darkThemeColor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BooksCompanion({
    this.bookId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lightThemeColor = const Value.absent(),
    this.darkThemeColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BooksCompanion.insert({
    this.bookId = const Value.absent(),
    required String title,
    required String description,
    required Color lightThemeColor,
    required Color darkThemeColor,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : title = Value(title),
        description = Value(description),
        lightThemeColor = Value(lightThemeColor),
        darkThemeColor = Value(darkThemeColor),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Book> custom({
    Expression<int>? bookId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? lightThemeColor,
    Expression<int>? darkThemeColor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (bookId != null) 'book_id': bookId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lightThemeColor != null) 'light_theme_color': lightThemeColor,
      if (darkThemeColor != null) 'dark_theme_color': darkThemeColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BooksCompanion copyWith(
      {Value<int>? bookId,
      Value<String>? title,
      Value<String>? description,
      Value<Color>? lightThemeColor,
      Value<Color>? darkThemeColor,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BooksCompanion(
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      description: description ?? this.description,
      lightThemeColor: lightThemeColor ?? this.lightThemeColor,
      darkThemeColor: darkThemeColor ?? this.darkThemeColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lightThemeColor.present) {
      final converter = $BooksTable.$converterlightThemeColor;
      map['light_theme_color'] =
          Variable<int>(converter.toSql(lightThemeColor.value));
    }
    if (darkThemeColor.present) {
      final converter = $BooksTable.$converterdarkThemeColor;
      map['dark_theme_color'] =
          Variable<int>(converter.toSql(darkThemeColor.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lightThemeColor: $lightThemeColor, ')
          ..write('darkThemeColor: $darkThemeColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FootprintsTable extends Footprints
    with TableInfo<$FootprintsTable, Footprint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FootprintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _footprintIdMeta =
      const VerificationMeta('footprintId');
  @override
  late final GeneratedColumn<int> footprintId = GeneratedColumn<int>(
      'footprint_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordDateMeta =
      const VerificationMeta('recordDate');
  @override
  late final GeneratedColumn<DateTime> recordDate = GeneratedColumn<DateTime>(
      'record_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [footprintId, bookId, message, recordDate, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'footprints';
  @override
  String get actualTableName => 'footprints';
  @override
  VerificationContext validateIntegrity(Insertable<Footprint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('footprint_id')) {
      context.handle(
          _footprintIdMeta,
          footprintId.isAcceptableOrUnknown(
              data['footprint_id']!, _footprintIdMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('record_date')) {
      context.handle(
          _recordDateMeta,
          recordDate.isAcceptableOrUnknown(
              data['record_date']!, _recordDateMeta));
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {footprintId};
  @override
  Footprint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Footprint(
      footprintId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}footprint_id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      recordDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}record_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FootprintsTable createAlias(String alias) {
    return $FootprintsTable(attachedDatabase, alias);
  }
}

class Footprint extends DataClass implements Insertable<Footprint> {
  final int footprintId;
  final int bookId;
  final String message;
  final DateTime recordDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Footprint(
      {required this.footprintId,
      required this.bookId,
      required this.message,
      required this.recordDate,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['footprint_id'] = Variable<int>(footprintId);
    map['book_id'] = Variable<int>(bookId);
    map['message'] = Variable<String>(message);
    map['record_date'] = Variable<DateTime>(recordDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FootprintsCompanion toCompanion(bool nullToAbsent) {
    return FootprintsCompanion(
      footprintId: Value(footprintId),
      bookId: Value(bookId),
      message: Value(message),
      recordDate: Value(recordDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Footprint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Footprint(
      footprintId: serializer.fromJson<int>(json['footprintId']),
      bookId: serializer.fromJson<int>(json['bookId']),
      message: serializer.fromJson<String>(json['message']),
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'footprintId': serializer.toJson<int>(footprintId),
      'bookId': serializer.toJson<int>(bookId),
      'message': serializer.toJson<String>(message),
      'recordDate': serializer.toJson<DateTime>(recordDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Footprint copyWith(
          {int? footprintId,
          int? bookId,
          String? message,
          DateTime? recordDate,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Footprint(
        footprintId: footprintId ?? this.footprintId,
        bookId: bookId ?? this.bookId,
        message: message ?? this.message,
        recordDate: recordDate ?? this.recordDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Footprint(')
          ..write('footprintId: $footprintId, ')
          ..write('bookId: $bookId, ')
          ..write('message: $message, ')
          ..write('recordDate: $recordDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      footprintId, bookId, message, recordDate, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Footprint &&
          other.footprintId == this.footprintId &&
          other.bookId == this.bookId &&
          other.message == this.message &&
          other.recordDate == this.recordDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FootprintsCompanion extends UpdateCompanion<Footprint> {
  final Value<int> footprintId;
  final Value<int> bookId;
  final Value<String> message;
  final Value<DateTime> recordDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FootprintsCompanion({
    this.footprintId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.message = const Value.absent(),
    this.recordDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FootprintsCompanion.insert({
    this.footprintId = const Value.absent(),
    required int bookId,
    required String message,
    required DateTime recordDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : bookId = Value(bookId),
        message = Value(message),
        recordDate = Value(recordDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Footprint> custom({
    Expression<int>? footprintId,
    Expression<int>? bookId,
    Expression<String>? message,
    Expression<DateTime>? recordDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (footprintId != null) 'footprint_id': footprintId,
      if (bookId != null) 'book_id': bookId,
      if (message != null) 'message': message,
      if (recordDate != null) 'record_date': recordDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FootprintsCompanion copyWith(
      {Value<int>? footprintId,
      Value<int>? bookId,
      Value<String>? message,
      Value<DateTime>? recordDate,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return FootprintsCompanion(
      footprintId: footprintId ?? this.footprintId,
      bookId: bookId ?? this.bookId,
      message: message ?? this.message,
      recordDate: recordDate ?? this.recordDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (footprintId.present) {
      map['footprint_id'] = Variable<int>(footprintId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (recordDate.present) {
      map['record_date'] = Variable<DateTime>(recordDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FootprintsCompanion(')
          ..write('footprintId: $footprintId, ')
          ..write('bookId: $bookId, ')
          ..write('message: $message, ')
          ..write('recordDate: $recordDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attachmentIdMeta =
      const VerificationMeta('attachmentId');
  @override
  late final GeneratedColumn<int> attachmentId = GeneratedColumn<int>(
      'attachment_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _footprintIdMeta =
      const VerificationMeta('footprintId');
  @override
  late final GeneratedColumn<int> footprintId = GeneratedColumn<int>(
      'footprint_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _filepathMeta =
      const VerificationMeta('filepath');
  @override
  late final GeneratedColumn<String> filepath =
      GeneratedColumn<String>('filepath', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _storedAtMeta =
      const VerificationMeta('storedAt');
  @override
  late final GeneratedColumn<DateTime> storedAt = GeneratedColumn<DateTime>(
      'stored_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [attachmentId, footprintId, filename, filepath, position, storedAt];
  @override
  String get aliasedName => _alias ?? 'attachments';
  @override
  String get actualTableName => 'attachments';
  @override
  VerificationContext validateIntegrity(Insertable<Attachment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attachment_id')) {
      context.handle(
          _attachmentIdMeta,
          attachmentId.isAcceptableOrUnknown(
              data['attachment_id']!, _attachmentIdMeta));
    }
    if (data.containsKey('footprint_id')) {
      context.handle(
          _footprintIdMeta,
          footprintId.isAcceptableOrUnknown(
              data['footprint_id']!, _footprintIdMeta));
    } else if (isInserting) {
      context.missing(_footprintIdMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('filepath')) {
      context.handle(_filepathMeta,
          filepath.isAcceptableOrUnknown(data['filepath']!, _filepathMeta));
    } else if (isInserting) {
      context.missing(_filepathMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('stored_at')) {
      context.handle(_storedAtMeta,
          storedAt.isAcceptableOrUnknown(data['stored_at']!, _storedAtMeta));
    } else if (isInserting) {
      context.missing(_storedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attachmentId};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      attachmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attachment_id'])!,
      footprintId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}footprint_id'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      filepath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filepath'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      storedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}stored_at'])!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final int attachmentId;
  final int footprintId;
  final String filename;
  final String filepath;
  final int position;
  final DateTime storedAt;
  const Attachment(
      {required this.attachmentId,
      required this.footprintId,
      required this.filename,
      required this.filepath,
      required this.position,
      required this.storedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attachment_id'] = Variable<int>(attachmentId);
    map['footprint_id'] = Variable<int>(footprintId);
    map['filename'] = Variable<String>(filename);
    map['filepath'] = Variable<String>(filepath);
    map['position'] = Variable<int>(position);
    map['stored_at'] = Variable<DateTime>(storedAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      attachmentId: Value(attachmentId),
      footprintId: Value(footprintId),
      filename: Value(filename),
      filepath: Value(filepath),
      position: Value(position),
      storedAt: Value(storedAt),
    );
  }

  factory Attachment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      attachmentId: serializer.fromJson<int>(json['attachmentId']),
      footprintId: serializer.fromJson<int>(json['footprintId']),
      filename: serializer.fromJson<String>(json['filename']),
      filepath: serializer.fromJson<String>(json['filepath']),
      position: serializer.fromJson<int>(json['position']),
      storedAt: serializer.fromJson<DateTime>(json['storedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attachmentId': serializer.toJson<int>(attachmentId),
      'footprintId': serializer.toJson<int>(footprintId),
      'filename': serializer.toJson<String>(filename),
      'filepath': serializer.toJson<String>(filepath),
      'position': serializer.toJson<int>(position),
      'storedAt': serializer.toJson<DateTime>(storedAt),
    };
  }

  Attachment copyWith(
          {int? attachmentId,
          int? footprintId,
          String? filename,
          String? filepath,
          int? position,
          DateTime? storedAt}) =>
      Attachment(
        attachmentId: attachmentId ?? this.attachmentId,
        footprintId: footprintId ?? this.footprintId,
        filename: filename ?? this.filename,
        filepath: filepath ?? this.filepath,
        position: position ?? this.position,
        storedAt: storedAt ?? this.storedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('attachmentId: $attachmentId, ')
          ..write('footprintId: $footprintId, ')
          ..write('filename: $filename, ')
          ..write('filepath: $filepath, ')
          ..write('position: $position, ')
          ..write('storedAt: $storedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      attachmentId, footprintId, filename, filepath, position, storedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.attachmentId == this.attachmentId &&
          other.footprintId == this.footprintId &&
          other.filename == this.filename &&
          other.filepath == this.filepath &&
          other.position == this.position &&
          other.storedAt == this.storedAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> attachmentId;
  final Value<int> footprintId;
  final Value<String> filename;
  final Value<String> filepath;
  final Value<int> position;
  final Value<DateTime> storedAt;
  const AttachmentsCompanion({
    this.attachmentId = const Value.absent(),
    this.footprintId = const Value.absent(),
    this.filename = const Value.absent(),
    this.filepath = const Value.absent(),
    this.position = const Value.absent(),
    this.storedAt = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.attachmentId = const Value.absent(),
    required int footprintId,
    required String filename,
    required String filepath,
    required int position,
    required DateTime storedAt,
  })  : footprintId = Value(footprintId),
        filename = Value(filename),
        filepath = Value(filepath),
        position = Value(position),
        storedAt = Value(storedAt);
  static Insertable<Attachment> custom({
    Expression<int>? attachmentId,
    Expression<int>? footprintId,
    Expression<String>? filename,
    Expression<String>? filepath,
    Expression<int>? position,
    Expression<DateTime>? storedAt,
  }) {
    return RawValuesInsertable({
      if (attachmentId != null) 'attachment_id': attachmentId,
      if (footprintId != null) 'footprint_id': footprintId,
      if (filename != null) 'filename': filename,
      if (filepath != null) 'filepath': filepath,
      if (position != null) 'position': position,
      if (storedAt != null) 'stored_at': storedAt,
    });
  }

  AttachmentsCompanion copyWith(
      {Value<int>? attachmentId,
      Value<int>? footprintId,
      Value<String>? filename,
      Value<String>? filepath,
      Value<int>? position,
      Value<DateTime>? storedAt}) {
    return AttachmentsCompanion(
      attachmentId: attachmentId ?? this.attachmentId,
      footprintId: footprintId ?? this.footprintId,
      filename: filename ?? this.filename,
      filepath: filepath ?? this.filepath,
      position: position ?? this.position,
      storedAt: storedAt ?? this.storedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attachmentId.present) {
      map['attachment_id'] = Variable<int>(attachmentId.value);
    }
    if (footprintId.present) {
      map['footprint_id'] = Variable<int>(footprintId.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (filepath.present) {
      map['filepath'] = Variable<String>(filepath.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (storedAt.present) {
      map['stored_at'] = Variable<DateTime>(storedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('attachmentId: $attachmentId, ')
          ..write('footprintId: $footprintId, ')
          ..write('filename: $filename, ')
          ..write('filepath: $filepath, ')
          ..write('position: $position, ')
          ..write('storedAt: $storedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $BooksTable books = $BooksTable(this);
  late final $FootprintsTable footprints = $FootprintsTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final BooksDao booksDao = BooksDao(this as Database);
  late final FootprintsDao footprintsDao = FootprintsDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [books, footprints, attachments];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
