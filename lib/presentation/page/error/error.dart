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

/// エラー画面となるページ
class ErrorPage extends BasePage<ErrorPageExtra> {
  const ErrorPage({Key? key, required ErrorPageExtra extra})
      : super(key: key, extra: extra);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              if (AppRouter.of(context).canPop()) {
                AppRouter.of(context).pop();
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
