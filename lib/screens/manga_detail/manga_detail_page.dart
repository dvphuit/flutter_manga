import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manga/data/models/group_chap.dart';
import 'package:flutter_manga/screens/manga_detail/manga_detail_controller.dart';
import 'package:flutter_manga/screens/manga_detail/widgets/chapter_sheet.dart';
import 'package:flutter_manga/screens/widgets/SnapSheet.dart';
import 'package:flutter_manga/screens/widgets/custom_bottom_sheet.dart';
import 'package:flutter_manga/screens/widgets/cutom_sheet.dart';
import 'package:flutter_manga/screens/widgets/expandable_text.dart';
import 'package:get/get.dart';

class MangaDetailPage extends StatelessWidget {
  const MangaDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MangaDetailController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Get.back(),
          ),
        ),
        // body: Stack(
        //   children: [
        //     SingleChildScrollView(
        //       physics: BouncingScrollPhysics(),
        //       child: Wrap(
        //         direction: Axis.horizontal,
        //         spacing: 12,
        //         runSpacing: 12,
        //         children: [
        //           _cover(_.manga.cover),
        //           _mangaName(_.manga.name),
        //           _author(_.manga.author),
        //           _rating(),
        //           _stats(_.manga.shortLiked, _.manga.shortComment, _.manga.shortViews),
        //           _description(_.manga.description),
        //           _genres(_.manga.genres),
        //           SizedBox(height: context.height * .1)
        //         ],
        //       ),
        //     ),
        //     // _chapters(_.groupedChap),
        //   ],
        // ),
        body: CustomSheet(
          child: Container(color: Colors.blue),
          sheet: Container(color: Colors.red, height: 100),
        ),
      );
    });
  }

  _cover(String url) {
    return Center(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          width: 140,
          height: 180,
          imageUrl: url,
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 4,
      ),
    );
  }

  _mangaName(String name) {
    return Center(
      child: Text(
        name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  _author(String author) {
    return Center(
      child: Text(
        author,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
      ),
    );
  }

  _rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [true, true, true, true, false]
          .map((e) => Icon(
                e ? Icons.star : Icons.star_border,
                size: 12,
                color: Colors.orange,
              ))
          .toList(),
    );
  }

  _description(String description) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: ExpandableText(
        description,
        trimLines: 6,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
      ),
    );
  }

  _chapters(List<GroupedChap> groupedChap) {
    return CustomBottomSheet(
      // builder: (ctx, scroller) => ChapterSheet(
      //   scroller: scroller,
      //   groups: groupedChap,
      // ),
      builder: (ctx, scroller) => ChapterSheet(
        scroller: scroller,
        groups: groupedChap,
      ),
    );
  }

  _genres(List<String> genres) {
    return genres.isNullOrBlank
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: genres
                    .map(
                      (genre) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          genre,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.purple.shade500),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withAlpha(40),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }

  _stats(String liked, String followed, String views) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _statItem(Icons.remove_red_eye_sharp, Colors.amber, views),
        SizedBox(width: 12),
        _statItem(Icons.comment, Colors.purple, followed),
        SizedBox(width: 12),
        _statItem(Icons.thumb_up, Colors.redAccent, liked),
      ],
    );
  }

  _statItem(IconData icon, Color color, String value) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Container(
          height: 24,
          width: 24,
          child: Icon(
            icon,
            size: 12,
            color: Colors.white,
          ),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Text(
          value ?? '',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        )
      ],
    );
  }
}

class CoverClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * .75);
    path.cubicTo(0, size.height * .75, size.width * .25, size.height * .5, size.width * .75, size.height * .70);
    path.cubicTo(
        size.width * .75, size.height * .70, size.width * .85, size.height * .8, size.width, size.height * .65);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CoverClipper oldClipper) => true;
}
