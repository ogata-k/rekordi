import 'package:rekordi/component/locator.dart';

/// ログレベル
/// offで出力無効化、allで全出力
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
AppLogger logger() => AppLocator().get<AppLogger>();

/// アプリケーションのログ
class AppLogger {
  AppLogger(this._instance);

  final Logger _instance;

  // ignore: avoid_positional_boolean_parameters
  void initialize(LogLevel level, bool useLineInfo) =>
      _instance.initialize(level, useLineInfo);

  void finest(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.finest(message?.toString(), values, error, stackTrace);

  void finer(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.finer(message?.toString(), values, error, stackTrace);

  void fine(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.fine(message?.toString(), values, error, stackTrace);

  void debug(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.debug(message?.toString(), values, error, stackTrace);

  void info(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.info(message?.toString(), values, error, stackTrace);

  void warning(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.warning(message?.toString(), values, error, stackTrace);

  void error(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.error(message?.toString(), values, error, stackTrace);

  void emergency(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _instance.emergency(message?.toString(), values, error, stackTrace);
}

abstract class Logger {
  // ignore: avoid_positional_boolean_parameters
  void initialize(LogLevel level, bool useLineInfo);

  void finest(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void finer(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void fine(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void debug(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void info(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void warning(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void error(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  void emergency(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]);
}
