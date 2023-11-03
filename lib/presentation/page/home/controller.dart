import 'package:flutter/widgets.dart';
import 'package:rekordi/presentation/page/controller.dart';
import 'package:rekordi/presentation/page/home/model.dart';

class HomePageController extends IPageController<HomePageModel> {
  const HomePageController(HomePageModel model) : super(model);

  @override
  void start(BuildContext context) {
    // none
  }

  @override
  void dispose() {
    // none
  }

  void incrementCount() => model.increment();
}
