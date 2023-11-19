import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/route_setting.dart';

class HomePageRouteSetting extends IRouteSetting {
  HomePageRouteSetting({required this.pageTitle});

  factory HomePageRouteSetting.fromPathParams(
    Map<String, String> pathParameters,
    Map<String, List<String>> queryParameters,
  ) {
    return HomePageRouteSetting(
      pageTitle: IRouteSetting.getParam(
        queryParameters,
        pageTitleQueryKey,
        (value) {
          if (value.isEmpty || value[0].isEmpty) {
            return null;
          }

          return value[0];
        },
      ),
    );
  }

  static const String routePath = '/home';
  static const String pageTitleQueryKey = 'pageTitle';

  final String? pageTitle;

  @override
  String toRoutePath() {
    // パスパラメータがないのでこのまま
    return routePath;
  }

  @override
  RouteSetting toRouteSetting() => RouteSetting(
        path: toRoutePath(),
        queryParameters: {
          pageTitleQueryKey: pageTitle,
        },
      );
}
