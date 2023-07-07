import 'package:flutter/widgets.dart';

// ignore: avoid_classes_with_only_static_members
/// ページのエクストラデータ
abstract class BasePageExtra {
  const BasePageExtra();

  /// 絶対パス。呼び出し先を指定するときに利用する。
  String get absolutePagePath;
}

/// ページの基本となる抽象クラス
abstract class BasePage<E extends BasePageExtra> extends StatelessWidget {
  const BasePage({Key? key, required this.extra}) : super(key: key);

  final E extra;
}
