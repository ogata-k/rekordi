import 'package:flutter/material.dart';
import 'package:rekordi/component/router.dart';
import 'package:rekordi/presentation/page/base.dart';

// @todo 実際のエラーページ

class ErrorPageExtra extends BasePageExtra {
  ErrorPageExtra({required this.error});

  final Exception? error;

  static const routingPath = '/error';

  @override
  // not use
  String get absolutePagePath => '/error';
}

class ErrorPageController extends BasePageController {
  @override
  void dispose() {
    // none
  }
}

/// エラー画面となるページ
class ErrorPage extends BasePage<ErrorPageExtra, ErrorPageController> {
  const ErrorPage({Key? key, required ErrorPageExtra extra})
      : super(key: key, extra: extra);

  @override
  ErrorPageController createController(BuildContext context) {
    return ErrorPageController();
  }

  @override
  Widget buildPage(BuildContext context, ErrorPageController controller) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              if (router().canPop(context)) {
                router().pop(context);
              }
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Center(
        child: Text(extra.error?.toString() ?? 'UNKNOWN'),
      ),
    );
  }
}
