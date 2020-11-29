import 'package:flutter/material.dart';
import 'package:flutter_manga/data/models/group_chap.dart';
import 'package:flutter_manga/screens/widgets/tab_indicator.dart';
import 'package:get/get.dart';

class ChapterSheet extends StatelessWidget {
  final ScrollController scroller;
  final List<GroupedChap> groups;

  ChapterSheet({
    @required this.scroller,
    @required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: DefaultTabController(
          length: groups.length,
          child: CustomScrollView(
            controller: scroller,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: PersistentHeader(
                  height: 90,
                  widget: Column(
                    children: [
                      _headerDot(),
                      _header(48),
                      _tabBar(30),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: _chapPager(),
              ),
            ],
          ),
        ));
  }

  _headerDot() {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        print('drag vertical ${details.delta} ');
        scroller.jumpTo(details.primaryDelta);
      },
      child: Center(
        child: Container(
          width: 30,
          height: 4,
          margin: EdgeInsets.all(4),
          decoration:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey, borderRadius: BorderRadius.circular(99)),
        ),
      ),
    );
  }

  _header(double height) {
    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(icon: Icon(Icons.sort), onPressed: () => null),
          Text(
            '123 chapters',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(99),
                boxShadow: [BoxShadow(color: Colors.deepPurple, blurRadius: 5)]),
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(8),
            child: Text(
              'Start reading',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _tabBar(double height) {
    return Container(
      height: height,
      child: TabBar(
        indicator: TabIndicator(
          size: 3,
          color: Colors.deepPurpleAccent,
        ),
        indicatorWeight: 0,
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
        isScrollable: true,
        labelPadding: EdgeInsets.all(4),
        physics: BouncingScrollPhysics(),
        tabs: groups
            .map(
              (e) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(99)),
                shape: BoxShape.rectangle,
                color: Colors.black.withAlpha(50)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Center(
              child: Text(e.title, style: TextStyle(fontSize: 12),),
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  _chapPager() {
    return TabBarView(
      children: groups
          .map((e) => ListView.builder(
              itemCount: e.chaps.length,
              physics: ClampingScrollPhysics(),
              // controller: scroller,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.chaps[index].name),
                        Text(e.chaps[index].publishDate),
                      ],
                    ),
                  )))
          .toList(),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  PersistentHeader({this.widget, this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: height,
      child: Card(
        child: widget,
        elevation: .2,
        margin: EdgeInsets.all(0),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
