import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String email = 'email';
  static const String token = 'token';

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(email) ?? '';
  }

  static Future<void> setEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(email, value);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  static Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, value);
  }
}
