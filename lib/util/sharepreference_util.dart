import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceUtil {
  SharePreferenceUtil._internal() {
    ///初始化
  }

  factory SharePreferenceUtil() => getInstance();
  static SharePreferenceUtil _sharePreferenceUtil;

  static SharePreferenceUtil getInstance() {
    if (_sharePreferenceUtil == null) {
      _sharePreferenceUtil = SharePreferenceUtil._internal();
    }
    return _sharePreferenceUtil;
  }

  putIntValue(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value ?? 0);
  }

  getIntValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  putStringValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value ?? "");
  }

  getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  putBoolValue(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value ?? false);
  }

  getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  putDoubleValue(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value ?? 0);
  }

  getDoubleValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0;
  }

  putStringListValue(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value ?? []);
  }

  getStringListValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}
