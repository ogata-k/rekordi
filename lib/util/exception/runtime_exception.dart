/// Exceptionの基本形
class RuntimeException implements Exception {
  const RuntimeException(this.title, this.description);

  final String title;
  final String description;

  @override
  String toString() {
    return '$runtimeType($title: $description)';
  }
}
