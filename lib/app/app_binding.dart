import 'package:get/get.dart';
import 'package:mytodo/app/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
  }
}
