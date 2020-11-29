import 'package:flutter/material.dart';
import 'package:flutter_manga/data/categories.dart';
import 'package:flutter_manga/data/models/manga.dart';
import 'package:flutter_manga/screens/home/home_controller.dart';
import 'package:flutter_manga/utils/common.dart';
import 'package:get/get.dart';

import 'widgets/auto_slide_banner.dart';

class HomePage extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {},
      builder: (_) {
        return Scaffold(
          body: _body(),
        );
      },
    );
  }

  Widget _body() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          var category = controller.categories[index];
          if (category is RecommendedBanner) {
            return AutoSlideBanner(
              mangas: category.data,
            );
          } else {
            return SectionList(
              title: category.name,
              list: category.data,
            );
          }
        });
  }
}

class SectionList extends StatefulWidget {
  final String title;
  final List<Manga> list;

  SectionList({Key key, @required this.title, @required this.list});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SectionList> {
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _title(),
          widget.list.isNullOrBlank
              ? Container(
                  height: 220,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : _list()
        ],
      ),
    );
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 8),
          width: 10,
          height: 5,
          color: Colors.red,
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget _list() {
    return Container(
      height: 234,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (_, index) => _item(widget.list[index]),
      ),
    );
  }

  Widget _item(Manga item) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  NetImg(url: item.cover, width: 130, height: 180),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                          color: Colors.redAccent,
                        ),
                        alignment: Alignment.center,
                        width: 40,
                        height: 25,
                        child: Text(
                          item.lastChapNum,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                item.name,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
      onTap: () => controller.gotoDetail(item),
    );
  }
}
