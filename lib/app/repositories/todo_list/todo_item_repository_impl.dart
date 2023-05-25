import 'package:clock/clock.dart';

import '../../core/database/id_generator/id_generator.dart';
import '../../core/database/key_value_storage/key_value_storage.dart';
import '../../models/todo_item_model.dart';
import 'todo_item_repository.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  TodoItemRepositoryImpl(
    this._keyValueStorage,
    this._idGenerator,
  );

  final KeyValueStorage _keyValueStorage;

  final IdGenerator _idGenerator;

  static const _todoListKey = 'todo_list';

  @override
  Future<void> create(String content, {bool isDone = false}) async {
    final list = await getAll();
    final todoItem = TodoItemModel(
      id: _idGenerator.generate(),
      content: content,
      isDone: isDone,
      createdAt: clock.now(),
    );
    await _keyValueStorage.setStringList(
      _todoListKey,
      [todoItem.toJson(), ...list.map((t) => t.toJson())],
    );
  }

  @override
  Future<void> delete(String id) async {
    final list = await getAll();
    final filteredList = list.where((todoItem) => todoItem.id != id);
    final noItemsFound = filteredList.length == list.length;
    if (noItemsFound) return;

    await _keyValueStorage.setStringList(
      _todoListKey,
      filteredList.map((todoItem) => todoItem.toJson()).toList(growable: false),
    );
  }

  @override
  Future<List<TodoItemModel>> getAll() async {
    final list = await _keyValueStorage.getStringList(_todoListKey);
    if (list == null) return [];
    return list.map(TodoItemModel.fromJson).toList(growable: false);
  }
}
