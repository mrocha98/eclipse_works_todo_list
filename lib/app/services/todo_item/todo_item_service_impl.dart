import '../../models/todo_item_model.dart';
import '../../repositories/todo_list/todo_item_repository.dart';
import 'todo_item_service.dart';

class TodoItemServiceImpl implements TodoItemService {
  TodoItemServiceImpl(this._todoItemRepository);

  final TodoItemRepository _todoItemRepository;

  @override
  Future<void> create(String content, {bool isDone = false}) =>
      _todoItemRepository.create(content, isDone: isDone);

  @override
  Future<void> delete(String id) => _todoItemRepository.delete(id);

  @override
  Future<List<TodoItemModel>> getAll() => _todoItemRepository.getAll();
}
