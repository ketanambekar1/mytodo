import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytodo/constants/app_constants.dart';

class ThemeService {
  static const _key = AppConstants.isDarkMode;
  final _box = GetStorage();

  bool get isDarkMode {
    if (_box.hasData(_key)) {
      return _box.read(_key);
    } else {
      return Get.isPlatformDarkMode;
    }
  }

  ThemeMode get theme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    final newValue = !isDarkMode;
    _box.write(_key, newValue);
    Get.changeThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
  }
}
