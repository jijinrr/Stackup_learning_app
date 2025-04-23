import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/utils/sharedpreference.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  // Reactive variable to track dark mode
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  // Load theme from SharedPreferences
  void loadTheme() async {
    await SharedPrefs.init(); // Ensure SharedPrefs is initialized
    isDarkMode.value = SharedPrefs.getBool('isDarkMode') ?? false;
  }

  // Toggle theme and save preference
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    SharedPrefs.saveBool('isDarkMode', isDarkMode.value);
  }

  // Set theme explicitly
  void setTheme(bool darkMode) {
    isDarkMode.value = darkMode;
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
    SharedPrefs.saveBool('isDarkMode', darkMode);
  }
}
