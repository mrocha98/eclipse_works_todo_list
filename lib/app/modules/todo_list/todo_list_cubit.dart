import 'package:bloc/bloc.dart';

import '../../models/todo_item_model.dart';
import '../../services/todo_item/todo_item_service.dart';
import 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit(this._todoItemService) : super(TodoListState.initial());

  final TodoItemService _todoItemService;

  Future<void> loadTodos() async {
    emit(state.copyWith(status: TodoListStatus.loading));

    final todos = await _todoItemService.getAll();
    final filtered = _filter(state.filterType, todos);

    emit(
      state.copyWith(
        status: TodoListStatus.loaded,
        todos: todos,
        filteredTodos: filtered,
      ),
    );
  }

  Future<void> createTodo(String content) async {
    emit(state.copyWith(status: TodoListStatus.loading));

    await _todoItemService.create(content);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    emit(state.copyWith(status: TodoListStatus.loading));

    await _todoItemService.delete(id);
    await loadTodos();
  }

  List<TodoItemModel> _filterByNone(List<TodoItemModel> list) => [...list];

  List<TodoItemModel> _filterByPending(List<TodoItemModel> list) =>
      list.where((todo) => todo.isDone == false).toList(growable: false);

  List<TodoItemModel> _filterByDone(List<TodoItemModel> list) =>
      list.where((todo) => todo.isDone == true).toList(growable: false);

  List<TodoItemModel> _filter(
    TodoFilterType filterType,
    List<TodoItemModel> list,
  ) =>
      switch (filterType) {
        TodoFilterType.pending => _filterByPending(list),
        TodoFilterType.done => _filterByDone(list),
        _ => _filterByNone(list),
      };

  void changeFilterType(TodoFilterType filterType) {
    final filtered = _filter(filterType, state.todos);
    emit(state.copyWith(filterType: filterType, filteredTodos: filtered));
  }

  Future<void> checkOrUncheck(TodoItemModel todo) async {
    emit(state.copyWith(status: TodoListStatus.loading));

    await _todoItemService.checkOrUncheck(todo);
    await loadTodos();
  }
}
