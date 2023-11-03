import 'package:flutter/widgets.dart';
import 'package:rekordi/presentation/page/model.dart';

/// ページのコントローラー
abstract class IPageController<M extends IPageModel> {
  const IPageController(this._model);

  final M _model;

  M get model => _model;

  void start(BuildContext context);

  void dispose();
}
