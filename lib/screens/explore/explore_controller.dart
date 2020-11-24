import 'package:flutter_manga/data/models/manga.dart';
import 'package:flutter_manga/data/repositories/manga_repo.dart';
import 'package:flutter_manga/routes/app_routes.dart';
import 'package:flutter_manga/screens/BaseController.dart';

class ExploreController extends BaseController<MangaRepo> {
  var scrollOffset = 0.0;
  List<Manga> banner = [];

  @override
  void onReady() {
    // _getBanner();
  }

  Future<void> _getBanner() async {
    print("get banner");
    var fromServer = await repo.getBanner();
    print('res banner -> ${fromServer.length}');
    if (fromServer.isNotEmpty) {
      banner = fromServer;
      update(); //will update different items
      print('update from api');
    }
  }

  Manga detailArgs;

  void _gotoDetail(dynamic args) {
    this.detailArgs = args;
    print("goto detail $args");
    mainController.toRouteNamed(AppRoutes.MANGA_DETAIL, args: args);
  }

  @override
  void onRouteChanged() {
    print('disappear explore page');
  }
}
