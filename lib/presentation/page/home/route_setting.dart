import 'dart:convert';

import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/route_setting.dart';

class HomePageRouteSetting extends IRouteSetting {
  HomePageRouteSetting({required this.pageTitle});

  static const String routePath = '/';
  static const String routeName = 'home';

  static const String pageTitleQueryKey = 'pageTitle';

  final String? pageTitle;

  @override
  RouteSetting toRouteSetting() => RouteSetting(
        name: routeName,
        pathParameters: {},
        queryParameters: {
          pageTitleQueryKey: pageTitle,
        },
      );

  String toInitialLocation() {
    final buffer = StringBuffer(routePath);
    final Map<String, dynamic> queryParameters = {
      pageTitleQueryKey: pageTitle,
    };

    bool isFirst = true;
    for (final MapEntry<String, dynamic> param in queryParameters.entries) {
      if (param.value == null) {
        continue;
      }
      buffer.write(isFirst ? '?' : '&');
      isFirst = false;
      buffer.write('${param.key}=${jsonEncode(param.value)}');
    }

    return buffer.toString();
  }
}
