import 'package:rekordi/util/error/runtime_error.dart';

/// 初期化がまだされていないときのエラー
class NotInitializeError extends RuntimeError {
  NotInitializeError({
    String description = 'Not initialized this class',
  }) : super('Not Initialized', description);
}
