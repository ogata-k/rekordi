/// Errorの基本形
class RuntimeError extends Error {
  RuntimeError(this.title, this.description);

  final String title;
  final String description;

  @override
  String toString() {
    return '$runtimeType($title: $description)';
  }
}

/// 引数の型などが想定していない値の時のエラー
/// enumのswitchで対応漏れがあった時のエラーにも使用する
class InvalidArgumentError extends RuntimeError {
  InvalidArgumentError(
    this.arg, {
    String description = 'The provided argument is invalid',
  }) : super('Invalid argument: $arg', description);

  final String arg;
}

/// 届かないことを想定して実装している箇所で発生するエラー
class UnreachableError extends RuntimeError {
  UnreachableError({String description = 'Called unreachable code'})
      : super('Unreachable code', description);
}

/// 初期化がまだされていないときのエラー
class NotInitializeError extends RuntimeError {
  NotInitializeError({
    String description = 'Not initialized this class',
  }) : super('Not Initialized', description);
}

/// 実装がサポートされていないときのエラー
class NotSupportError extends RuntimeError {
  NotSupportError({
    String description = 'Not support this implements',
  }) : super('Not Support', description);
}
