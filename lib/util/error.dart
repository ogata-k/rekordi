/// Errorの基本形
class GeneralError extends Error {
  GeneralError(this.title, this.description);

  final String title;
  final String description;

  @override
  String toString() {
    return '$runtimeType($title: $description)';
  }
}

/// 引数の型などが想定していない値の時のエラー
/// enumのswitchで対応漏れがあった時のエラーにも使用する
class InvalidArgumentError extends GeneralError {
  InvalidArgumentError(
    this.arg, {
    String description = 'The provided argument is invalid',
  }) : super('Invalid argument: $arg', description);

  final String arg;
}

/// 届かないことを想定して実装している箇所で発生するエラー
class UnreachableError extends GeneralError {
  UnreachableError({String description = 'Called unreachable code'})
      : super('Unreachable code', description);
}

/// 初期化がまだされていないときのエラー
class NotInitializeError extends GeneralError {
  NotInitializeError({
    String description = 'Not initialized this class',
  }) : super('Not Initialized', description);
}

/// 実装がサポートされていないときのエラー
class NotSupportError extends GeneralError {
  NotSupportError({
    String description = 'Not support this implements',
  }) : super('Not Support', description);
}
