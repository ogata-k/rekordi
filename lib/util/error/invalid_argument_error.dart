import 'package:rekordi/util/error/runtime_error.dart';

/// 引数の型などが想定していない値の時のエラー
/// enumのswitchで対応漏れがあった時のエラーにも使用する
class InvalidArgumentError extends RuntimeError {
  InvalidArgumentError(
    this.arg, {
    String description = 'The provided argument is invalid',
  }) : super('Invalid argument: $arg', description);

  final String arg;
}
