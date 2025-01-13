import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefs {
  static String chatVllm = "chatVllm";

  static SharedPreferences? _sharedPrefs;

  removeKey(String key) {
    _sharedPrefs?.remove(key);
  }

  Future<void> init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }



  static String getString(String key, [String? defValue]) {
    return _sharedPrefs?.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    return _sharedPrefs?.setString(key, value) ?? Future.value(false);
  }
  static Future<bool> removeString(String key) async {
    return _sharedPrefs?.remove(key) ?? Future.value(false);
  }


  static Future<String> clearPreference() async {
    _sharedPrefs?.clear();
    return "";
  }
}

final sharedPrefs = SharedPrefs();