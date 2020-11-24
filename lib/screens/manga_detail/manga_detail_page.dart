import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manga/screens/manga_detail/manga_detail_controller.dart';
import 'package:flutter_manga/utils/app_theme.dart';
import 'package:get/get.dart';

class MangaDetailPage extends StatelessWidget {
  const MangaDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MangaDetailController>(builder: (_) {
      return Scaffold(
        body: Obx((){
          var chaps = _.isUpdated.value;
          return DefaultTabController(
            length: _.groupedChap.length,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: primaryColor,
                    expandedHeight: 250.0,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    title: Text(_.manga.name),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        margin: EdgeInsets.only(top: 78),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                width: 140,
                                height: 180,
                                imageUrl: _.manga.cover,
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                            ),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  Text(_.manga?.author ?? ""),
                                  Text(_.manga?.status ?? ""),
                                  _genres(_.manga.genres),
                                  _stats(_.manga.liked, _.manga.followed, _.manga.views)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(tabs: _.groupedChap.map((e) => Tab(text: e.title)).toList(), isScrollable: true,),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Center(
                child: ListView.builder(itemBuilder: (_, index) => Text('item $index')),
              ),
            ),
          );
        }),
      );
    });
  }

  _genres(List<String> genres) {
    return genres.isNullOrBlank
        ? Container()
        : Container(
            margin: EdgeInsets.only(right: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: genres
                  .map(
                    (genre) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Text(
                        genre,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
  }

  _stats(String liked, String followed, String views) {
    return Row(
      children: [
        _statItem(Icons.thumb_up, liked),
        SizedBox(width: 16),
        _statItem(Icons.remove_red_eye_sharp, views),
      ],
    );
  }

  _statItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
        ),
        Text(
          value ?? '',
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => 30;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
