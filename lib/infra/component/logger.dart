import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as lg;
import 'package:rekordi/domain/component/interface/logger.dart' as dc;
import 'package:rekordi/domain/component/interface/logger.dart';
import 'package:rekordi/util/error/unreachable_error.dart';
import 'package:stack_trace/stack_trace.dart' show Frame, Trace;

/// loggingパッケージのLogger具象クラス
class LoggingLogger extends dc.ILogger {
  static const String _loggerName = 'Rekordi';
  final lg.Logger _logger = lg.Logger(_loggerName);

  /// loggingパッケージで扱えるLevelに変換
  static lg.Level _toLoggingLevel(dc.LogLevel logLevel) {
    switch (logLevel) {
      case dc.LogLevel.all:
        return lg.Level.ALL;
      case dc.LogLevel.finest:
        return lg.Level.FINEST;
      case dc.LogLevel.finer:
        return lg.Level.FINER;
      case dc.LogLevel.fine:
        return lg.Level.FINE;
      case dc.LogLevel.debug:
        return lg.Level.CONFIG;
      case dc.LogLevel.info:
        return lg.Level.INFO;
      case dc.LogLevel.warning:
        return lg.Level.WARNING;
      case dc.LogLevel.error:
        return lg.Level.SEVERE;
      case dc.LogLevel.emergency:
        return lg.Level.SHOUT;
      case dc.LogLevel.off:
        return lg.Level.OFF;
    }
  }

  /// loggingパッケージのLevelをコンポーネントのレベルに変換
  static dc.LogLevel _toComponentLogLevel(lg.Level level) {
    switch (level) {
      case lg.Level.ALL:
        return dc.LogLevel.all;
      case lg.Level.FINEST:
        return dc.LogLevel.finest;
      case lg.Level.FINER:
        return dc.LogLevel.finer;
      case lg.Level.FINE:
        return dc.LogLevel.fine;
      case lg.Level.CONFIG:
        return dc.LogLevel.debug;
      case lg.Level.INFO:
        return dc.LogLevel.info;
      case lg.Level.WARNING:
        return dc.LogLevel.warning;
      case lg.Level.SEVERE:
        return dc.LogLevel.error;
      case lg.Level.SHOUT:
        return dc.LogLevel.emergency;
      case lg.Level.OFF:
        return dc.LogLevel.off;
      default:
        throw UnreachableError();
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
  void initialize(
    dc.LogLevel level,
    bool useLineInfo,
    void Function(LogLevel level, String message) callback,
  ) {
    lg.Logger.root.level = _toLoggingLevel(level);
    lg.Logger.root.onRecord.listen((lg.LogRecord rec) {
      String message =
          // ignore: lines_longer_than_80_chars
          '[${rec.loggerName}: ${rec.sequenceNumber}]  ${rec.time}  ${_toComponentLogLevel(rec.level).name.toUpperCase()}  ${rec.message}';

      if (useLineInfo) {
        final Frame currentLineInfo = Trace.current(11).frames.first;
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
      callback(level, message);
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
