import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget NetImg({
  double width,
  double height,
  @required String url,
}){
  return CachedNetworkImage(
    height: height,
    width: width,
    httpHeaders: Map()..putIfAbsent("Referer", () => 'http://truyenqq.com'),
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) => new Center(child: Icon(Icons.image)),
    errorWidget: (context, url, error) => new Icon(Icons.error),
  );
}

