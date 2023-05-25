import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui/helpers/size_extensions.dart';
import '../todo_list_cubit.dart';
import '../todo_list_state.dart';

class TodoListFilters extends StatelessWidget {
  const TodoListFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListCubit, TodoListState>(
      bloc: context.read<TodoListCubit>(),
      buildWhen: (previous, current) => switch (current.status) {
        TodoListStatus.initial => true,
        TodoListStatus.loaded => true,
        TodoListStatus.loading => false,
      },
      builder: (context, state) => ToggleButtons(
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
    );
  }
}
