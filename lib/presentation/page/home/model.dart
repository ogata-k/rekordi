import 'package:flutter/widgets.dart';
import 'package:rekordi/presentation/page/model.dart';

class HomePageModel extends IPageModel with ChangeNotifier {
  HomePageModel(int initialCount) : _count = initialCount;

  int _count;

  int get currentCount => _count;

  void increment() {
    _count += 1;
    notifyListeners();
  }
}
