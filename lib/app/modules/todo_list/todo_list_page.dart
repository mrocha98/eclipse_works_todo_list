import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/helpers/loader_mixin.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/widgets/default_app_bar.dart';
import 'todo_list_cubit.dart';
import 'todo_list_state.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const DefaultAppBar(),
        body: BlocConsumer<TodoListCubit, TodoListState>(
          listener: (context, state) => switch (state.status) {
            TodoListStatus.loading => showLoader(),
            _ => hideLoader(),
          },
          bloc: context.read<TodoListCubit>(),
          buildWhen: (previous, current) => switch (current.status) {
            TodoListStatus.initial => true,
            TodoListStatus.loaded => true,
            _ => false,
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Center(
                    child: ToggleButtons(
                      isSelected: [
                        state.isFilteredByNone,
                        state.isFilteredByPending,
                        state.isFilteredByDone
                      ],
                      onPressed: (index) {
                        final filter = switch (index) {
                          1 => TodoFilterType.pending,
                          2 => TodoFilterType.done,
                          _ => TodoFilterType.none,
                        };
                        context.read<TodoListCubit>().changeFilterType(filter);
                      },
                      constraints: BoxConstraints(
                        minHeight: 38,
                        minWidth: context.percentWidth(.3) - 12,
                      ),
                      children: const [
                        Text('All'),
                        Text('pending'),
                        Text('done'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final todo = state.filteredTodos.elementAt(index);
                        return Dismissible(
                          key: Key(todo.id),
                          confirmDismiss: (_) async {
                            await context
                                .read<TodoListCubit>()
                                .deleteTodo(todo.id);
                            return true;
                          },
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
                          child: CheckboxListTile(
                            activeColor: Theme.of(context).primaryColor,
                            value: todo.isDone,
                            onChanged: (isDone) {
                              // TODO : update/toggle isDone
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              todo.content,
                              style: TextStyle(
                                decoration: todo.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: state.filteredTodos.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
