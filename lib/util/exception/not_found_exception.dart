import 'package:rekordi/util/exception/runtime_exception.dart';

// @todo replace to Option util model
/// 指定したものが見つからなかった場合のエラー
class NotFoundException extends RuntimeException {
  NotFoundException({String description = 'Specified data is not founded'})
      : super('Not founded data', description);
}
