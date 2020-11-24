import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import 'nav_pages.dart';
import 'widgets/bottom_nav.dart';

class MainPage extends GetWidget<MainController> {
  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _home();
  }

  Widget _home() {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => controller.openSearch(),
          ),
        ],
      ),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: navPages.first.route,
        onGenerateRoute: (settings) {
          return getNavRoutes(settings.name);
        },
      ),
      bottomNavigationBar: BottomNav(
        titles: navPages.map((e) => e.title).toList(),
        onNavClicked: (index) {
          print('selected index $index');
          controller.onNavClick(index);
        },
      ),
    );
  }
}
