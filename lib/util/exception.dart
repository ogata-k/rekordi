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

/// 指定したものが見つからなかった場合のエラー
class NotFoundException extends GeneralException {
  NotFoundException({String description = 'Specified data is not founded'})
      : super('Not founded data', description);
}
