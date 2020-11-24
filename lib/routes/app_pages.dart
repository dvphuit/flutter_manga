import 'package:flutter_manga/screens/main_binding.dart';
import 'package:flutter_manga/screens/main_page.dart';
import 'package:flutter_manga/screens/manga_detail/manga_detail_binding.dart';
import 'package:flutter_manga/screens/manga_detail/manga_detail_page.dart';
import 'package:get/route_manager.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.MANGA_DETAIL,
      page: () => MangaDetailPage(),
      binding: MangaDetailBinding(),
      transition: Transition.cupertino
    ),
  ];
}