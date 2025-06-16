import 'package:get/get.dart';
import 'package:mytodo/theme/app_theme_service.dart';

class ThemeController extends GetxController {
  final themeService = ThemeService();

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    isDarkMode.value = themeService.isDarkMode;
    super.onInit();
  }

  void toggleTheme() {
    themeService.toggleTheme();
    isDarkMode.value = !isDarkMode.value;
  }
}
