import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_item_model.dart';
import '../todo_list_cubit.dart';

class TodoItemDismissible extends StatelessWidget {
  const TodoItemDismissible({
    required this.todo,
    required this.child,
    super.key,
  });

  final TodoItemModel todo;

  final Widget child;

  Future<bool> _handleDeleteConfirmation(BuildContext context) async {
    final cubit = context.read<TodoListCubit>();
    var confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 6),
            Text(
              'Deletion confirmation',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            'You\'re about to delete the todo "${todo.content}", proceed?',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    confirmed ??= false;

    if (confirmed) {
      await cubit.deleteTodo(todo.id);
    }
    return confirmed;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      confirmDismiss: (_) async => _handleDeleteConfirmation(context),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(right: 12),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'DELETE',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}
