class FailUpdateException implements Exception {
  @pragma('vm:entry-point')
  const FailUpdateException([this.target, this.message]);

  /// Fail delete target
  final String? target;

  /// A message describing the format error.
  final String? message;

  @override
  String toString() {
    final String? target = this.target;
    final String? message = this.message;
    String result = 'FailUpdateException';
    if (target != null) {
      result = '$result: Fail update $target.';
    }
    if (message != null) {
      result = '$result: $message';
    }

    return result;
  }
}
