import 'dart:ui';

import 'package:drift/drift.dart';

// 自動生成でも変換後の型を使えるようにexportする
export 'dart:ui' show Color;

/// 色を宣言するためのコンバーター
class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.value;
}
