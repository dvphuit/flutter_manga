import 'package:flutter_manga/screens/main_controller.dart';
import 'package:get/get.dart';

abstract class BaseController<T> extends GetxController {
  final mainController = Get.find<MainController>();
  final repo = Get.find<T>();
}
