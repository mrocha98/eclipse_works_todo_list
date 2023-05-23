import 'package:provider/provider.dart';

import '../../core/database/key_value_storage/key_value_storage.dart';
import '../../core/module/module.dart';
import '../../repositories/theme_mode/theme_mode_repository.dart';
import '../../repositories/theme_mode/theme_mode_repository_impl.dart';
import '../../services/theme_mode/theme_mode_service.dart';
import '../../services/theme_mode/theme_mode_service_impl.dart';
import 'theme_mode_controller.dart';

class ThemeModeModule extends Module {
  ThemeModeModule()
      : super(
          routes: {},
          binds: [
            Provider<ThemeModeRepository>(
              create: (context) => ThemeModeRepositoryImpl(
                context.read<KeyValueStorage>(), // global
              ),
            ),
            Provider<ThemeModeService>(
              create: (context) => ThemeModeServiceImpl(
                context.read<ThemeModeRepository>(),
              ),
            ),
            ChangeNotifierProvider<ThemeModeController>(
              create: (context) => ThemeModeController(
                context.read<ThemeModeService>(),
              ),
            ),
          ],
        );
}
