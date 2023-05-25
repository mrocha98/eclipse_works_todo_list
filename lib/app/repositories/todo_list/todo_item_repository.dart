import '../../models/todo_item_model.dart';

abstract interface class TodoItemRepository {
  Future<void> create(
    String content, {
    bool isDone = false,
  });
  Future<void> delete(String id);
  Future<List<TodoItemModel>> getAll();
}
