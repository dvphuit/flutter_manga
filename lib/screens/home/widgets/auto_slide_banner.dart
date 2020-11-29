import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manga/data/models/manga.dart';

import 'indicator.dart';

class AutoSlideBanner extends StatefulWidget {
  final List<Manga> mangas;

  AutoSlideBanner({Key key, this.mangas});

  @override
  State<StatefulWidget> createState() {
    return _SlideState();
  }
}

class _SlideState extends State<AutoSlideBanner> {
  var _index = 0.0;
  final int _infinite = 922337203685477580;

  final _controller = PageController(viewportFraction: 1);
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _index = _controller.page % widget.mangas.length / 1.0;
      setState(() {});
    });
    _initAutoSlider();
  }

  void _initAutoSlider() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
        _controller.nextPage(duration: Duration(seconds: 2), curve: Curves.ease);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.mangas != null ? Stack(
      children: [
        Container(
          height: 180,
          child: _pager(),
        ),

        Positioned(
          bottom: 8,
          right: 12,
          child: Indicator(widget.mangas.length, _index),
        ),
      ],
    ) : Container();
  }

  Widget _pager() {
    return PageView.builder(
      controller: _controller,
      itemCount: _infinite,
      pageSnapping: true,
      itemBuilder: (BuildContext context, int i) {
        var index = i % widget.mangas.length;
        return Listener(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  httpHeaders: Map()..putIfAbsent("Referer", () => 'http://truyenqq.com'),
                  imageUrl: widget.mangas[index].cover,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => new Center(child: Icon(Icons.image)),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      begin: Alignment(0, 1),
                      end: Alignment(0, 0.4),
                      stops: [0, 1],
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                ),
                Positioned(
                  child: Text(
                    widget.mangas[index].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 5.0,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 6.0,
                          color: Colors.deepPurpleAccent,
                        ),
                      ],
                    ),
                  ),
                  left: 4,
                  bottom: 4,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      widget.mangas[index].lastChap,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                      color: Colors.cyan,
                    ),
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),
          onPointerDown: (event) {
            _timer.cancel();
            _timer = null;
          },
          onPointerUp: (event) {
            _initAutoSlider();
          },
        );
      },
    );
  }
}
