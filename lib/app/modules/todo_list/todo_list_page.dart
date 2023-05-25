import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/ui/helpers/loader_mixin.dart';
import '../../core/ui/widgets/default_app_bar.dart';
import 'todo_list_cubit.dart';
import 'todo_list_state.dart';
import 'widgets/todo_item_form.dart';
import 'widgets/todo_list.dart';
import 'widgets/todo_list_filters.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  static const routeName = '/';

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with Loader {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<TodoListCubit>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: BlocListener<TodoListCubit, TodoListState>(
        listener: (context, state) => switch (state.status) {
          TodoListStatus.loading => showLoader(),
          _ => hideLoader(),
        },
        bloc: context.read<TodoListCubit>(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(
                child: TodoListFilters(),
              ),
            ),
            Expanded(
              child: TodoList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todoListCubit =
              Provider.of<TodoListCubit>(context, listen: false);
          showModalBottomSheet<dynamic>(
            context: context,
            builder: (context) => Provider.value(
              value: todoListCubit,
              child: const TodoItemForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
