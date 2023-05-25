import '../../models/todo_item_model.dart';

abstract interface class TodoItemService {
  Future<void> create(
    String content, {
    bool isDone = false,
  });
  Future<void> delete(String id);
  Future<List<TodoItemModel>> getAll();
  Future<void> checkOrUncheck(TodoItemModel todo);
}
