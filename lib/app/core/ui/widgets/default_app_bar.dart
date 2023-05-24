import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modules/theme_mode/theme_mode_controller.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('To do list'),
      centerTitle: true,
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
    );
  }
}
