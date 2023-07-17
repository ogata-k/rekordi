import 'dart:ui';

import 'package:drift/drift.dart';

export 'dart:ui' show Color;

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.value;
}
