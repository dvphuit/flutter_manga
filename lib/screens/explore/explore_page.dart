import 'package:flutter/material.dart';
import 'package:flutter_manga/screens/explore/explore_controller.dart';
import 'package:get/get.dart';


class ExplorePage extends StatelessWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      initState: (state) {},
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text("Explore"),
          )
        );
      },
    );
  }

}
