import 'package:flutter/foundation.dart';

import '../../models/todo_item_model.dart';

enum TodoListStatus {
  initial,
  loading,
  loaded,
}

enum TodoFilterType {
  none,
  pending,
  done,
}

@immutable
class TodoListState {
  const TodoListState({
    required this.status,
    required this.todos,
    required this.filteredTodos,
    required this.filterType,
  });

  TodoListState.initial()
      : status = TodoListStatus.initial,
        todos = const <TodoItemModel>[],
        filteredTodos = <TodoItemModel>[],
        filterType = TodoFilterType.none;

  final TodoListStatus status;

  final List<TodoItemModel> todos;

  final List<TodoItemModel> filteredTodos;

  final TodoFilterType filterType;

  bool get isFilteredByNone => filterType == TodoFilterType.none;

  bool get isFilteredByPending => filterType == TodoFilterType.pending;

  bool get isFilteredByDone => filterType == TodoFilterType.done;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoListState &&
        other.status == status &&
        listEquals(other.todos, todos) &&
        listEquals(other.filteredTodos, filteredTodos) &&
        other.filterType == filterType;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        todos.hashCode ^
        filteredTodos.hashCode ^
        filterType.hashCode;
  }

  @override
  String toString() {
    return 'TodoListState('
        'status: $status, '
        'todos: $todos, '
        'filteredTodos: $filteredTodos, '
        'filterType: $filterType'
        ')';
  }

  TodoListState copyWith({
    TodoListStatus? status,
    List<TodoItemModel>? todos,
    List<TodoItemModel>? filteredTodos,
    TodoFilterType? filterType,
  }) {
    return TodoListState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      filteredTodos: filteredTodos ?? this.filteredTodos,
      filterType: filterType ?? this.filterType,
    );
  }
}
