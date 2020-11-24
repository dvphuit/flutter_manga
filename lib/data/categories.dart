import 'models/manga.dart';

class CategoryData{
  final String name;
  List<Manga> data;
  CategoryData({this.name, this.data});
}

abstract class Category {
  String get name;

  String get route;

  List<Manga> data = [];

  @override
  String toString() {
    return '[$name, ${data.length}]';
  }
}

class RecommendedBanner implements Category {
  @override
  String get name => 'Banner';

  @override
  String get route => '';

  @override
  List<Manga> data;

}

class LastUpdate implements Category {
  @override
  String get name => 'Last Update';

  @override
  String get route => '/truyen-moi-cap-nhat.html?country=4';

  @override
  List<Manga> data;
}

class Favourite implements Category {
  @override
  String get name => 'Favourite';

  @override
  String get route => '/truyen-yeu-thich.html?country=4';

  @override
  List<Manga> data;
}

class TopMonth implements Category {
  @override
  String get name => 'Top Month';

  @override
  String get route => '/top-thang.html?country=4';

  @override
  List<Manga> data;
}
