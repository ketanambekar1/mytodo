import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/app/app_binding.dart';
import 'package:mytodo/routes/app_routes.dart';
import 'package:mytodo/theme/app_theme.dart';
import 'package:mytodo/theme/app_theme_service.dart';
import 'package:mytodo/widgets/bottom_nav/bottom_navbar_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeService().theme,
      getPages: AppPages.routes,
      home: BottomNavView(),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
    );
  }
}
