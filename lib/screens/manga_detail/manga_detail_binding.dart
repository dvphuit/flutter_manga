import 'package:get/get.dart';

import 'manga_detail_controller.dart';

class MangaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MangaDetailController());
  }
}
