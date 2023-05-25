import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/todo_item_model.dart';
import '../todo_list_cubit.dart';
import '../todo_list_state.dart';
import 'todo_item_dismissible.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocSelector<TodoListCubit, TodoListState, List<TodoItemModel>>(
        selector: (state) => state.filteredTodos,
        bloc: context.read<TodoListCubit>(),
        builder: (context, filteredTodos) => ListView.separated(
          itemBuilder: (context, index) {
            final todo = filteredTodos.elementAt(index);
            return TodoItemDismissible(
              todo: todo,
              child: CheckboxListTile(
                activeColor: Theme.of(context).primaryColor,
                value: todo.isDone,
                onChanged: (_) =>
                    context.read<TodoListCubit>().checkOrUncheck(todo),
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  todo.content,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: filteredTodos.length,
        ),
      ),
    );
  }
}
