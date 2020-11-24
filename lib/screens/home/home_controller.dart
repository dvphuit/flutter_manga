import 'package:flutter_manga/data/categories.dart';
import 'package:flutter_manga/data/repositories/manga_repo.dart';
import 'package:flutter_manga/routes/app_routes.dart';
import 'package:flutter_manga/screens/BaseController.dart';
import 'package:get/get.dart';

class HomeController extends BaseController<MangaRepo> {
  var scrollOffset = 0.0;

  final List<Category> categories = [
    RecommendedBanner(),
    LastUpdate(),
    Favourite(),
    TopMonth(),
  ];

  @override
  void onReady() {
    _getBanner();
    categories.sublist(1).forEach((element) {
      _getCategory(element);
    });
  }

  Future<void> _getBanner() async {
    print("get banner");
    var fromServer = await repo.getBanner();
    print('res banner -> ${fromServer?.length}');
    if (fromServer.isNotEmpty) {
      categories.first.data = fromServer;
      update(); //will update different items
      print('update from api');
    }
  }

  Future<void> _getCategory(Category category) async {
    print("get category ${category.name}");
    var fromServer = await repo.getCategory(category);
    print('res category ${category.name} -> ${fromServer.data.length}');
    if (fromServer.data.isNotEmpty) {
      update(); //will update different items
    }
  }


  void gotoDetail(dynamic args) {
    print("goto detail $args");
    Get.toNamed(AppRoutes.MANGA_DETAIL, arguments: args);
  }
}
