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
