import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'core/ui/theme/dark_theme.dart';
import 'core/ui/theme/light_theme.dart';
import 'modules/theme_mode/theme_mode_controller.dart';
import 'modules/todo_list/todo_list_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ThemeModeController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse Works Todo List',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      themeMode: context.select<ThemeModeController, ThemeMode?>(
        (controller) => controller.themeMode,
      ),
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      routes: {
        ...TodoListModule().routes,
      },
      builder: EasyLoading.init(),
    );
  }
}
