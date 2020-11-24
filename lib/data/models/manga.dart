import 'package:flutter_manga/data/models/chapter.dart';
import 'package:meta/meta.dart';

class Manga {
  final int id;
  final String name;
  final String cover;
  final String href;
  final String lastChap;
  String liked;
  String views;
  String followed;
  String author;
  String status;
  List<String> genres;
  List<Chapter> chaps;

  Manga({
    @required this.id,
    @required this.name,
    @required this.cover,
    @required this.href,
    this.lastChap,
    this.liked,
    this.views,
    this.followed,
    this.chaps,
    this.author,
    this.status,
    this.genres,
  });

  String get lastChapNum => lastChap.split(" ").last;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Manga && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ href.hashCode;

  @override
  String toString() {
    return "{$name, $cover, $href";
  }
}
