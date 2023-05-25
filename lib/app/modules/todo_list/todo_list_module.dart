import 'package:provider/provider.dart';

import '../../core/database/id_generator/id_generator.dart';
import '../../core/database/key_value_storage/key_value_storage.dart';
import '../../core/module/module.dart';
import '../../repositories/todo_list/todo_item_repository.dart';
import '../../repositories/todo_list/todo_item_repository_impl.dart';
import 'todo_list_cubit.dart';
import 'todo_list_page.dart';

class TodoListModule extends Module {
  TodoListModule()
      : super(
          routes: {TodoListPage.routeName: (context) => const TodoListPage()},
          binds: [
            Provider<TodoItemRepository>(
              create: (context) => TodoItemRepositoryImpl(
                context.read<KeyValueStorage>(),
                context.read<IdGenerator>(),
              ),
            ),
            Provider<TodoListCubit>(
              create: (context) => TodoListCubit(),
            ),
          ],
        );
}
