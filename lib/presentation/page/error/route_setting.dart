import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/route_setting.dart';

class ErrorPageRouteSetting extends IRouteSetting {
  ErrorPageRouteSetting({required this.error});

  factory ErrorPageRouteSetting.fromPathParams(
    Map<String, String> pathParameters,
    Map<String, List<String>> queryParameters,
  ) {
    return ErrorPageRouteSetting(
      error: IRouteSetting.getParam(
        queryParameters,
        errorQueryKey,
        (value) {
          if (value.isEmpty || value[0].isEmpty) {
            return null;
          }

          return value[0];
        },
      ),
    );
  }

  static const String routePath = '/error';
  static const String errorQueryKey = 'error';

  final String? error;

  @override
  String toRoutePath() {
    // パスパラメータがないのでこのまま
    return routePath;
  }

  @override
  RouteSetting toRouteSetting() => RouteSetting(
        path: toRoutePath(),
        queryParameters: {
          errorQueryKey: error,
        },
      );
}
