enum TodoListStatus {
  initial,
  loading,
  loaded,
  error,
}

class TodoListState {
  TodoListState.initial() : status = TodoListStatus.initial;

  final TodoListStatus status;
}
