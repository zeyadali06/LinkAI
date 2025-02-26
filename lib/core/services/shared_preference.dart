import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  Future<bool> set(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  Future<String?> get(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
}
