import 'package:flutter/material.dart';

import 'app/app_module.dart';
import 'app/core/database/key_value_storage/key_value_storage_shared_preferences_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KeyValueStorageSharedPreferencesImpl.instance.init();
  runApp(const AppModule());
}
