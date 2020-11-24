import 'package:flutter_manga/data/IData.dart';
import 'package:flutter_manga/data/categories.dart';
import 'package:flutter_manga/data/models/chapter.dart';
import 'package:flutter_manga/data/models/manga.dart';
import 'package:flutter_manga/data/providers/remote/base_scrapper.dart';
import 'package:html/dom.dart';

class MangaProvider extends BaseScrapper implements IMangaData {
  @override
  String get baseUrl => "http://truyenqq.com";

  @override
  Future<List<Manga>> get(Category category) async {
    var doc = await getDocument(path: category.route);
    var elements = doc.querySelectorAll('.story-item');
    return elements.map((e) => _parseItems(e)).toList();
  }

  @override
  Future<List<Manga>> getBanner() async {
    var doc = await getDocument();
    var elements = doc.querySelectorAll('.hero-item');
    return elements.map((e) => _parseBanner(e)).toList();
  }

  @override
  Future<Category> getCategory(Category category) async {
    var doc = await getDocument(path: category.route);
    var elements = doc.querySelectorAll('.story-item');
    category.data = elements.map((e) => _parseItems(e)).toList();
    return category;
  }

  @override
  Future<Manga> getMangaDetail(Manga manga) async{
    var doc = await getDocument(href: manga.href);

    var info = doc.querySelectorAll('p.info-item');
    manga.author = info[0].text;
    manga.status = info[1].text;

    var stat = doc.querySelectorAll('.sp01');
    manga.liked = stat[0].text;
    manga.followed = stat[1].text;
    manga.views = stat[2].text;

    manga.genres = doc.querySelectorAll('.list01 a').map((e) => e.text).toList();

    var chapElements = doc.querySelectorAll('.works-chapter-item a');
    manga.chaps = chapElements.map((e) => Chapter(name: e.text, href: e.attributes['href'])).toList();
    return manga;
  }

  Manga _parseBanner(Element element) {
    var href = element.parent.attributes['href'];
    return Manga(
      id: href.hashCode,
      name: element.querySelector('h3').text,
      cover: element.querySelector('.cover').attributes['src'],
      href: href,
      lastChap: element.querySelector('.chapter').text,
    );
  }

  Manga _parseItems(Element element) {
    var book = element.querySelector('a');
    return Manga(
      id: book.attributes['href'].hashCode,
      name: book.attributes['title'],
      cover: book.querySelector('img').attributes['src'],
      href: book.attributes['href'],
      lastChap: element.querySelector('.episode-book > a').text,
    );
  }



}
