import 'package:provider/provider.dart';

import '../../core/module/module.dart';
import 'todo_list_cubit.dart';
import 'todo_list_page.dart';

class TodoListModule extends Module {
  TodoListModule()
      : super(
          routes: {TodoListPage.routeName: (context) => const TodoListPage()},
          binds: [
            Provider<TodoListCubit>(
              create: (context) => TodoListCubit(),
            ),
          ],
        );
}
