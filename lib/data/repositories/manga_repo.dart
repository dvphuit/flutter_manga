import 'package:flutter_manga/data/IData.dart';
import 'package:flutter_manga/data/categories.dart';
import 'package:flutter_manga/data/models/manga.dart';
import 'package:flutter_manga/data/providers/remote/manga_provider.dart';

class MangaRepo implements IMangaData {
  final _remote = MangaProvider();

  @override
  Future<List<Manga>> getBanner() async {
    return await _remote.getBanner();
  }

  @override
  Future<List<Manga>> get(Category category) async {
    return await _remote.get(category);
  }

  @override
  Future<Category> getCategory(Category category) async {
    return await _remote.getCategory(category);
  }

  @override
  Future<Manga> getMangaDetail(Manga manga) async {
    return await _remote.getMangaDetail(manga);
  }


}
