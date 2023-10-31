import 'package:flutter/material.dart';
import 'package:rekordi/domain/component/router.dart';
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

class ErrorPageModel extends BasePageModel with ChangeNotifier {}

class ErrorPageController extends BasePageController<ErrorPageModel> {
  const ErrorPageController(ErrorPageModel model) : super(model);

  @override
  void start(BuildContext context) {
    // none
  }

  @override
  void dispose() {
    // none
  }
}

/// エラー画面となるページ
class ErrorPage
    extends BasePage<ErrorPageExtra, ErrorPageModel, ErrorPageController> {
  const ErrorPage({Key? key, required ErrorPageExtra extra})
      : super(key: key, extra: extra);

  @override
  ErrorPageController createController(ErrorPageExtra extra) {
    return ErrorPageController(ErrorPageModel());
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // none
  }
}
