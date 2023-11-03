import 'package:flutter/material.dart';
import 'package:rekordi/domain/component/router.dart';
import 'package:rekordi/presentation/page/error/controller.dart';
import 'package:rekordi/presentation/page/error/model.dart';
import 'package:rekordi/presentation/page/view.dart';

// @todo 実際のエラーページ

class ErrorPageExtra extends IPageExtra {
  ErrorPageExtra({required this.error});

  final Exception? error;

  static const routingPath = '/error';

  @override
  // not use
  String get absolutePagePath => '/error';
}

/// エラー画面となるページ
class ErrorPage
    extends IPage<ErrorPageExtra, ErrorPageModel, ErrorPageController> {
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
