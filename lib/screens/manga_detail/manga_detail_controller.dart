import 'package:flutter_manga/data/models/group_chap.dart';
import 'package:flutter_manga/data/models/manga.dart';
import 'package:flutter_manga/data/repositories/manga_repo.dart';
import 'package:flutter_manga/screens/BaseController.dart';
import "package:flutter_manga/utils/ext.dart";
import 'package:get/get.dart';


class MangaDetailController extends BaseController<MangaRepo> {
  Manga get manga => Get.arguments;

  List<GroupedChap> groupedChap = [];
  var isUpdated = false.obs;
  @override
  void onReady() {
    _getDetail();
  }

  Future<void> _getDetail() async {
    print("get detail");
    await repo.getMangaDetail(manga);
    isUpdated.value = true;
    groupedChap = manga.chaps.groupBy((e) => e.chapNum ~/ 50.05).values.map((entry) {
      var first = entry.first.chapNum.toInt();
      var last = entry.last.chapNum.toInt();
      return GroupedChap(title: '$first-$last', chaps: entry);
    }).toList();
    update();
  }
}
