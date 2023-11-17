/// ログレベル
/// enum宣言順にレベルが高くなっていき、初期化時にallで全出力でoffで出力無効化となる。
enum LogLevel {
  all,
  finest,
  finer,
  fine,
  debug,
  info,
  warning,
  error,
  emergency,
  off,
}

abstract class ILogger {
  /// 初期化
  // ignore: avoid_positional_boolean_parameters, lines_longer_than_80_chars
  void initialize(LogLevel level, bool useLineInfo,
      void Function(LogLevel level, String message) callback);

  /// [LogLevel.finest]のログ
  void finest(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.finer]のログ
  void finer(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.fine]のログ
  void fine(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.debug]のログ
  void debug(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.info]のログ
  void info(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.warning]のログ
  void warning(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.error]のログ
  void error(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  /// [LogLevel.emergency]のログ
  void emergency(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);
}
