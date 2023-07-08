/// Exceptionの基本形
class GeneralException implements Exception {
  const GeneralException(this.title, this.description);

  final String title;
  final String description;

  @override
  String toString() {
    return '$runtimeType($title: $description)';
  }
}

/// 引数の型などが想定していない値の時のエラー
/// enumのswitchで対応漏れがあった時のエラーにも使用する
class InvalidArgumentException extends GeneralException {
  const InvalidArgumentException(
    this.arg, {
    String description = 'The provided argument is invalid',
  }) : super('Invalid argument: $arg', description);

  final String arg;
}

/// 届かないことを想定して実装している箇所で発生するエラー
class UnreachableException extends GeneralException {
  const UnreachableException({String description = 'Called unreachable code'})
      : super('Unreachable code', description);
}

/// 取得しようとした値が見つからなかった時のエラー
class NotFoundException extends GeneralException {
  const NotFoundException({String description = 'Resource could not be found'})
      : super('Not Found', description);
}
