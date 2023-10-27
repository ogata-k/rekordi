import 'package:rekordi/util/error/runtime_error.dart';

/// 実装がサポートされていないときのエラー
class NotSupportError extends RuntimeError {
  NotSupportError({
    String description = 'Not support this implements',
  }) : super('Not Support', description);
}
