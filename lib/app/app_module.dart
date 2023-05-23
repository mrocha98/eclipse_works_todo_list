import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/database/key_value_storage/key_value_storage.dart';
import 'core/database/key_value_storage/key_value_storage_shared_preferences_impl.dart';
import 'modules/theme_mode/theme_mode_module.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<KeyValueStorage>(
          create: (context) => KeyValueStorageSharedPreferencesImpl.instance,
        ),
        ...ThemeModeModule().binds,
      ],
      child: const AppWidget(),
    );
  }
}
