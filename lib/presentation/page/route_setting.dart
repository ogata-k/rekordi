import 'package:rekordi/domain/component/router.dart';

/// 画面遷移に必要なパラメータをそろえたクラスのベースとなる抽象クラス
abstract class IRouteSetting {
  /// クエリパラメータをパースして値を取得する。
  /// [R]はStringかIterable<String>
  static T? getParam<R, T>(
    Map<String, R> params,
    String key,
    T? Function(R value) tryParse,
  ) {
    final R? value = params[key];
    if (value == null) {
      return null;
    }

    return tryParse(value);
  }

  /// 必要なパラメータをあてはめて、遷移するときのパスに変換する。
  String toRoutePath();

  /// 遷移するときのパラメータに変換
  RouteSetting toRouteSetting();
}
