import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  final ScrollableWidgetBuilder builder;

  CustomBottomSheet({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 90 / Get.height,
      minChildSize: 68 / Get.height,
      maxChildSize: 400 / Get.height,
      builder: (ctx, scroller) => builder(ctx, scroller),
    );
  }
}
