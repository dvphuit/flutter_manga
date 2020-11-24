import 'package:flutter/material.dart';
import 'package:flutter_manga/screens/main_binding.dart';
import 'package:flutter_manga/screens/main_page.dart';
import 'package:flutter_manga/utils/dependencies_injection.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  await DependenciesInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Manga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().darkTheme,
      home: MainPage(),
      initialBinding: MainBinding(),
      getPages: AppPages.pages,
      onInit: () {
        print('on app init');
      },
      onDispose: () {
        print('on app dispose');
      },
    );
  }
}
