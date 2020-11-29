import 'package:flutter_manga/data/models/chapter.dart';
import 'package:meta/meta.dart';
import "package:flutter_manga/utils/ext.dart";

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
  String description;
  String status;
  List<String> genres;
  String comment;
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
    this.description,
    this.comment,
  });

  String get lastChapNum => lastChap.split(" ").last;
  String get shortViews => views.shortenLargeNumber();
  String get shortFollowed => followed.shortenLargeNumber();
  String get shortLiked => liked.shortenLargeNumber();
  String get shortComment => comment.shortenLargeNumber();

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
