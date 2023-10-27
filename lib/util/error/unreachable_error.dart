import 'package:rekordi/util/error/runtime_error.dart';

/// 届かないことを想定して実装している箇所で発生するエラー
class UnreachableError extends RuntimeError {
  UnreachableError({String description = 'Called unreachable code'})
      : super('Unreachable code', description);
}
