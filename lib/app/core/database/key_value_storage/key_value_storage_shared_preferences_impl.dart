import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage.dart';

class KeyValueStorageSharedPreferencesImpl implements KeyValueStorage {
  KeyValueStorageSharedPreferencesImpl._internal();

  static KeyValueStorageSharedPreferencesImpl? _instance;

  static KeyValueStorageSharedPreferencesImpl get instance =>
      _instance ??= KeyValueStorageSharedPreferencesImpl._internal();

  late final SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<V?> get<V>(String key) async => _sharedPreferences.get(key) as V?;

  @override
  Future<bool> hasData(String key) async => _sharedPreferences.containsKey(key);

  @override
  Future<void> remove(String key) async => _sharedPreferences.remove(key);

  @override
  Future<void> set<V>(String key, V? value) async {
    switch (V) {
      case String:
        await _sharedPreferences.setString(key, value! as String);
      case int:
        await _sharedPreferences.setInt(key, value! as int);
      case bool:
        await _sharedPreferences.setBool(key, value! as bool);
      case double:
        await _sharedPreferences.setDouble(key, value! as double);
      default:
        throw Exception(
          'the value $value with type ${value.runtimeType} is unsupported',
        );
    }
  }
}
