abstract interface class KeyValueStorage {
  /// search [key] in storage and return the associated value if exists
  /// else return null
  Future<V?> get<V>(String key);

  /// stores the [value] in the [key] index
  Future<void> set<V>(String key, V? value);

  /// checks if the [key] contains a non-nullable value
  Future<bool> hasData(String key);

  /// deletes the entry with [key] from storage
  Future<void> remove(String key);
}
