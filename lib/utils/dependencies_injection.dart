import 'package:flutter_manga/data/repositories/manga_repo.dart';
import 'package:get/get.dart';

class DependenciesInjection{
  static Future<void> init() async {

    // repositories
    Get.put<MangaRepo>(MangaRepo());

  }
}