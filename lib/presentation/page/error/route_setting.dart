import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/route_setting.dart';

class ErrorPageRouteSetting extends IRouteSetting {
  ErrorPageRouteSetting({required this.error});

  static const String routePath = '/error';
  static const String routeName = 'error';
  static const String errorQueryKey = 'error';

  final String? error;

  @override
  RouteSetting toRouteSetting() => RouteSetting(
        name: routeName,
        pathParameters: {},
        queryParameters: {
          errorQueryKey: error,
        },
      );
}
