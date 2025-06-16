import 'package:get/get.dart';
import 'package:mytodo/screens/categories/category_view.dart';
import 'package:mytodo/screens/dashboard/dashboard_view.dart';
import 'package:mytodo/screens/priorities/priority_view.dart';

class AppRoutes {
  static const dashboard = '/';
  static const priority = '/priority';
  static const category = '/category';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
    ),
    GetPage(
      name: AppRoutes.priority,
      page: () => PriorityView(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => CategoryView(),
    ),
  ];
}
