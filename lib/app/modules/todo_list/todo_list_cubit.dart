import 'package:bloc/bloc.dart';

import '../../services/todo_item/todo_item_service.dart';
import 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit(this._todoItemService) : super(TodoListState.initial());

  final TodoItemService _todoItemService;
}
