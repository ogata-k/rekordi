import 'package:rekordi/domain/component/router.dart';

/// 画面遷移に必要なパラメータをそろえたクラスのベースとなる抽象クラス
// ignore: one_member_abstracts
abstract class IRouteSetting {
  RouteSetting toRouteSetting();
}
