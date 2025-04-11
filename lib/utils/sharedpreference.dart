import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  static Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get a string value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save a boolean value
  static Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Get a boolean value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Remove a specific key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all preferences
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  // Save a custom plan (example method)
  static void savePlan(String key, String value) {
    // Implement your custom save logic here
    saveString(key, value);
  }

  static void savePlanId(String key, String value) {
    // Implement your custom save logic here
    saveString(key, value);
  }
}
