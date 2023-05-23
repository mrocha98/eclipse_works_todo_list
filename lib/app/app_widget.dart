import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/theme_mode/theme_mode_controller.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse Works Todo List',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      themeMode: context.select<ThemeModeController, ThemeMode?>(
        (controller) => controller.themeMode,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Selector<ThemeModeController, ThemeMode?>(
              selector: (context, controller) => controller.themeMode,
              builder: (context, themeMode, _) {
                return Visibility(
                  visible: themeMode == ThemeMode.light,
                  replacement: IconButton(
                    onPressed: () => context
                        .read<ThemeModeController>()
                        .changeTheme(ThemeMode.light),
                    icon: const Icon(Icons.light_mode),
                  ),
                  child: IconButton(
                    onPressed: () => context
                        .read<ThemeModeController>()
                        .changeTheme(ThemeMode.dark),
                    icon: const Icon(Icons.dark_mode),
                  ),
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('Bem começado, metade feito'),
        ),
      ),
    );
  }
}
