import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static const String keyUser = 'user';
  static const String keyCart = 'cart';
  static const String keyOrders = 'orders';

  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static Future<void> setString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }
}


