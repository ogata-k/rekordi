import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:rekordi/component/logger.dart' as component;
import 'package:rekordi/util/exception.dart';
import 'package:stack_trace/stack_trace.dart' show Frame, Trace;

/// loggingパッケージのLogger具象クラス
class LoggingLogger extends component.Logger {
  static const String _loggerName = 'Rekordi';
  final Logger _logger = Logger(_loggerName);

  /// loggingパッケージで扱えるLevelに変換
  static Level _toLoggingLevel(component.LogLevel logLevel) {
    switch (logLevel) {
      case component.LogLevel.all:
        return Level.ALL;
      case component.LogLevel.finest:
        return Level.FINEST;
      case component.LogLevel.finer:
        return Level.FINER;
      case component.LogLevel.fine:
        return Level.FINE;
      case component.LogLevel.debug:
        return Level.CONFIG;
      case component.LogLevel.info:
        return Level.INFO;
      case component.LogLevel.warning:
        return Level.WARNING;
      case component.LogLevel.error:
        return Level.SEVERE;
      case component.LogLevel.emergency:
        return Level.SHOUT;
      case component.LogLevel.off:
        return Level.OFF;
    }
  }

  /// loggingパッケージのLevelをコンポーネントのレベルに変換
  static component.LogLevel _toComponentLogLevel(Level level) {
    switch (level) {
      case Level.ALL:
        return component.LogLevel.all;
      case Level.FINEST:
        return component.LogLevel.finest;
      case Level.FINER:
        return component.LogLevel.finer;
      case Level.FINE:
        return component.LogLevel.fine;
      case Level.CONFIG:
        return component.LogLevel.debug;
      case Level.INFO:
        return component.LogLevel.info;
      case Level.WARNING:
        return component.LogLevel.warning;
      case Level.SEVERE:
        return component.LogLevel.error;
      case Level.SHOUT:
        return component.LogLevel.emergency;
      case Level.OFF:
        return component.LogLevel.off;
      default:
        throw const UnreachableException();
    }
  }

  /// 出力するメッセージ形式に変換
  String _formatValues(Object? message, Map<String, Object?> values) =>
      '$message\t$values';

  /// 指定したメッセージのログを出力する
  void _printLog(String message) {
    debugPrint(message);
  }

  @override
  void initialize(component.LogLevel level, bool useLineInfo) {
    Logger.root.level = _toLoggingLevel(level);
    Logger.root.onRecord.listen((LogRecord rec) {
      String message =
          // ignore: lines_longer_than_80_chars
          '[${rec.loggerName}: ${rec.sequenceNumber}]  ${rec.time}  ${_toComponentLogLevel(rec.level).name.toUpperCase()}  ${rec.message}';

      if (useLineInfo) {
        final Frame currentLineInfo =
            Trace.current(rec.loggerName == _loggerName ? 11 : 9).frames.first;
        message +=
            // ignore: lines_longer_than_80_chars
            ' (${currentLineInfo.uri}:${currentLineInfo.line}:${currentLineInfo.column})';
      }

      if (rec.error != null || rec.stackTrace != null) {
        message += '\nerror:';
        if (rec.error != null) {
          message += '  ${rec.error}';
        }

        if (rec.stackTrace != null) {
          message += '\n${rec.stackTrace}';
        }
      }
      _printLog(message);
    });
  }

  @override
  void finest(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.finest(_formatValues(message, values), error, stackTrace);

  @override
  void finer(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.finer(_formatValues(message, values), error, stackTrace);

  @override
  void fine(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.fine(_formatValues(message, values), error, stackTrace);

  @override
  void debug(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.config(_formatValues(message, values), error, stackTrace);

  @override
  void info(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.info(_formatValues(message, values), error, stackTrace);

  @override
  void warning(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.warning(_formatValues(message, values), error, stackTrace);

  @override
  void error(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.severe(_formatValues(message, values), error, stackTrace);

  @override
  void emergency(
    Object? message,
    Map<String, Object?> values, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.shout(_formatValues(message, values), error, stackTrace);
}
