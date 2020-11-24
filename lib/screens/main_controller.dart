import 'package:get/get.dart';
import 'nav_pages.dart';

class MainController extends GetxController {
  final _currentIndex = 0.obs;

  final routeState = navPages.asMap().map((key, value) => MapEntry(key, value.route));

  int get currentIndex => this._currentIndex.value;

  var title = navPages[0].title.obs;

  RxBool inDetail = false.obs;

  void onNavClick(int index) {
    if (index == this._currentIndex.value) return;

    this._currentIndex.value = index;
    this.title.value = navPages[currentIndex].title;

    toRouteIndex(index);
  }

  void toRouteNamed(String name, {dynamic args}) {
    routeState[currentIndex] = name;
    Get.toNamed(name, arguments: args, id: 1);
    inDetail.value = routeState[currentIndex] != navPages[currentIndex].route;
  }

  void toRouteIndex(int index) {
    Get.toNamed(routeState[index], id: 1);
    inDetail.value = routeState[currentIndex] != navPages[currentIndex].route;
  }

  void closeDetail() {
    routeState[currentIndex] = navPages[currentIndex].route;
    Get.offNamed(routeState[currentIndex], id: 1);
    inDetail.value = routeState[currentIndex] != navPages[currentIndex].route;
  }

  void openSearch() {

  }
}
