import 'package:flutter/material.dart';
import 'package:flutter_manga/screens/library/library_controller.dart';
import 'package:get/get.dart';


class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LibraryController>(
      initState: (state) {},
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text("Library"),
          )
        );
      },
    );
  }

}
