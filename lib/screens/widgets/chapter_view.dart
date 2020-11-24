import 'package:flutter/material.dart';

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

class ChapterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChapViewState();
}

class ChapViewState extends State<ChapterView> with SingleTickerProviderStateMixin {
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  List<TabTitle> tabList;
  var currentPage = 0;
  var isPageCanChanged = true;

  @override
  void initState() {
    super.initState();
    initTabData();
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        print(mTabController.index);
        onPageChange(mTabController.index, p: mPageController);
      }
    });
  }

  initTabData() {
    tabList = [
      new TabTitle('recommended', 10),
      new TabTitle('hotspot', 0),
      new TabTitle('Society', 1),
      new TabTitle('Entertainment', 2),
      new TabTitle('Sports', 3),
      new TabTitle(' ', 4),
      new TabTitle('Technology', 5),
      new TabTitle(' ', 6),
      new TabTitle('Fashion', 7)
    ];
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyTabBarDelegate(
            child: TabBar(
              isScrollable: true,
              controller: mTabController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            )
          ),
        ),
        SliverFillRemaining(
          child: PageView.builder(
            itemCount: tabList.length,
            onPageChanged: (index) {
              if(isPageCanChanged) {
                onPageChange(index);
              }
            },
            controller: mPageController,
            itemBuilder: (BuildContext context, int index) {
              return Text(tabList[index].title);
            },
          ),
        )
      ],
    );
  }
}


class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}