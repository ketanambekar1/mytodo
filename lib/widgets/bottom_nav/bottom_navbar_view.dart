import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/screens/add_tasks/add_task_bottom_sheet.dart';
import 'package:mytodo/screens/dashboard/dashboard_view.dart';
import 'package:mytodo/theme/app_theme_controller.dart';
import 'package:mytodo/widgets/app_drawer/app_drawer_view.dart';
import 'package:mytodo/widgets/bottom_nav/bottom_navbar_controller.dart';
import 'package:mytodo/theme/app_colors.dart';

class BottomNavView extends StatelessWidget {
  BottomNavView({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final ThemeController themController = Get.put(ThemeController());

  final List<Widget> pages =  [
    DashboardView(),
    const Placeholder(),
  ];

  void _openAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: const Text("MyToDo")),
          drawer: const AppDrawerView(),
          body: pages[controller.currentIndex.value],
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.red,
            onPressed: () => _openAddTaskSheet(context),
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 30),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            selectedItemColor: AppColors.red,
            unselectedItemColor: AppColors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'ToDos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Reports',
              ),
            ],
          ),
        ));
  }
}
