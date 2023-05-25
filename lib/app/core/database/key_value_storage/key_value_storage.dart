abstract interface class KeyValueStorage {
  /// search [key] in storage and return the associated value if exists
  /// else return null
  Future<V?> get<V>(String key);

  /// search [key] in storage and return the associated list if exists
  /// else return null
  Future<List<String>?> getStringList(String key);

  /// stores the [value] in the [key] index
  Future<void> set<V>(String key, V? value);

  /// stores the [values] in the list with [key]
  Future<void> setStringList(String key, List<String> values);

  /// checks if the [key] contains a non-nullable value
  Future<bool> hasData(String key);

  /// deletes the entry with [key] from storage
  Future<void> remove(String key);
}
