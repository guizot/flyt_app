import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceDataSource {
  // Init
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<bool> containsKey(String key) async =>
      (await _instance).containsKey(key);

  // Getters
  Future<String> getString(String key, [String? defaultValue]) =>
      _instance.then((prefs) => prefs.getString(key) ?? defaultValue ?? '');

  Future<int> getInt(String key, [int? defaultValue]) =>
      _instance.then((prefs) => prefs.getInt(key) ?? defaultValue ?? 0);

  Future<bool> getBool(String key, [bool? defaultValue]) =>
      _instance.then((prefs) => prefs.getBool(key) ?? defaultValue ?? false);

  Future<double> getDouble(String key, [double? defaultValue]) =>
      _instance.then((prefs) => prefs.getDouble(key) ?? defaultValue ?? 0.0);

  // Setters
  Future<bool> setString(String key, String value) =>
      _instance.then((prefs) => prefs.setString(key, value));

  Future<bool> setInt(String key, int value) =>
      _instance.then((prefs) => prefs.setInt(key, value));

  Future<bool> setBool(String key, bool value) =>
      _instance.then((prefs) => prefs.setBool(key, value));

  Future<bool> setDouble(String key, double value) =>
      _instance.then((prefs) => prefs.setDouble(key, value));

  // Remove
  Future<bool> remove(String key) =>
      _instance.then((prefs) => prefs.remove(key));
}
