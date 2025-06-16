import 'package:get/get.dart';
import 'package:mytodo/db/category_operations/category_services.dart';
import 'package:mytodo/db/priority_operations/priority_services.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  void _initializeApp() {
    CategoryService().initializeDefaultCategories();
    PriorityService().initializeDefaultPriorities();
  }
}
