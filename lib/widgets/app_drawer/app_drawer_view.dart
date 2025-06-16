import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/routes/app_routes.dart';
import 'package:mytodo/screens/categories/category_view.dart';
import 'package:mytodo/screens/priorities/priority_view.dart';
import 'package:mytodo/theme/app_colors.dart';
import 'package:mytodo/theme/app_theme_controller.dart';

class AppDrawerView extends StatelessWidget {
  const AppDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.red,
            ),
            child: Text(
              'Welcome, Pirate!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),

          Obx(() => SwitchListTile(
                secondary: Icon(
                  themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                  color: themeController.isDarkMode.value ? Colors.yellow : Colors.orange,
                ),
                title: Text(themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode'),
                value: themeController.isDarkMode.value,
                onChanged: (val) {
                  themeController.toggleTheme();
                },
              )),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.category);
            },
          ),
          ListTile(
            leading: const Icon(Icons.priority_high),
            title: const Text('Priorities'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoutes.priority);
            },
          ),
        ],
      ),
    );
  }
}
