import 'package:flutter/material.dart';
import 'package:flutter_manga/routes/app_routes.dart';
import 'package:flutter_manga/screens/explore/explore_binding.dart';
import 'package:flutter_manga/screens/explore/explore_page.dart';
import 'package:flutter_manga/screens/library/library_binding.dart';
import 'package:flutter_manga/screens/library/library_page.dart';
import 'package:get/get.dart';

import 'home/home_binding.dart';
import 'home/home_page.dart';

class Page {
  final String title;
  final String route;

  Page({
    Key key,
    @required this.title,
    @required this.route,
  });
}

final List<Page> navPages = [
  Page(
    title: "Home",
    route: AppRoutes.HOME,
  ),
  Page(
    title: "Explore",
    route: AppRoutes.EXPLORE,
  ),
  Page(
    title: "Library",
    route: AppRoutes.LIBRARY,
  ),
];

GetPageRoute getNavRoutes(name) {
  Widget page;
  Bindings binding;
  Transition transition;
  switch (name) {
    case AppRoutes.HOME:
      page = HomePage();
      binding = HomeBinding();
      break;
    case AppRoutes.EXPLORE:
      page = ExplorePage();
      binding = ExploreBinding();
      break;
    case AppRoutes.LIBRARY:
      page = LibraryPage();
      binding = LibraryBinding();
      break;
  }
  return GetPageRoute(
    page: () => page,
    binding: binding,
    transition: transition ?? Transition.fadeIn,
  );
}
