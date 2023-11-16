import 'package:rekordi/presentation/page/controller.dart';
import 'package:rekordi/presentation/page/home/model.dart';

class HomePageController extends IPageController<HomePageModel> {
  HomePageController(super._state);

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}
