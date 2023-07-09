import 'package:rekordi/component/locator.dart';

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

/// 簡単に扱うためのヘルパ
AppLogger logger() => locator().get<AppLogger>();

/// アプリケーションのログ
class AppLogger {
  const AppLogger(this._instance);

  final Logger _instance;

  /// ロガーの初期化
  // ignore: avoid_positional_boolean_parameters
  void initialize(LogLevel level, bool useLineInfo) =>
      _instance.initialize(level, useLineInfo);

  /// [LogLevel.finest]のログ
  void finest(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.finest(message?.toString(), values, error, stackTrace);

  /// [LogLevel.finer]のログ
  void finer(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.finer(message?.toString(), values, error, stackTrace);

  /// [LogLevel.fine]のログ
  void fine(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.fine(message?.toString(), values, error, stackTrace);

  /// [LogLevel.debug]のログ
  void debug(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.debug(message?.toString(), values, error, stackTrace);

  /// [LogLevel.info]のログ
  void info(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.info(message?.toString(), values, error, stackTrace);

  /// [LogLevel.warning]のログ
  void warning(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.warning(message?.toString(), values, error, stackTrace);

  /// [LogLevel.error]のログ
  void error(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.error(message?.toString(), values, error, stackTrace);

  /// [LogLevel.emergency]のログ
  void emergency(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.emergency(message?.toString(), values, error, stackTrace);
}

abstract class Logger {
  /// 初期化
  // ignore: avoid_positional_boolean_parameters
  void initialize(LogLevel level, bool useLineInfo);

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
