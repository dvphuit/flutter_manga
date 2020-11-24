import 'package:flutter_manga/data/categories.dart';
import 'package:flutter_manga/data/models/manga.dart';

abstract class IMangaData {
  Future<List<Manga>> get(Category category);

  Future<Category> getCategory(Category category);

  Future<List<Manga>> getBanner();

  Future<Manga> getMangaDetail(Manga manga);
}
