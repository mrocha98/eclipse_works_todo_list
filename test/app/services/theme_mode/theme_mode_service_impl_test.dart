import 'package:eclipse_works_todo_list/app/repositories/theme_mode/theme_mode_repository.dart';
import 'package:eclipse_works_todo_list/app/services/theme_mode/theme_mode_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ThemeModeRepositoryMockImpl extends Mock implements ThemeModeRepository {}

void main() {
  late ThemeModeServiceImpl sut;
  late ThemeModeRepositoryMockImpl themeModeRepositoryMock;

  setUp(() {
    themeModeRepositoryMock = ThemeModeRepositoryMockImpl();
    sut = ThemeModeServiceImpl(themeModeRepositoryMock);
  });

  group('.getThemeData', () {
    test('should call ThemeModeRepository.getThemeData', () async {
      when(() => themeModeRepositoryMock.getThemeMode())
          .thenAnswer((_) async => null);

      await sut.getThemeMode();

      verify(() => themeModeRepositoryMock.getThemeMode()).called(1);
    });

    test('should return ThemeModeRepository.getThemeData', () async {
      when(() => themeModeRepositoryMock.getThemeMode())
          .thenAnswer((_) async => ThemeMode.system);

      final themeMode = await sut.getThemeMode();

      expect(themeMode, ThemeMode.system);
    });
  });

  group('.save', () {
    test('should call ThemeModeRepository.save', () async {
      when(() => themeModeRepositoryMock.save(ThemeMode.light))
          .thenAnswer((_) async {});

      await sut.save(ThemeMode.light);

      verify(() => themeModeRepositoryMock.save(ThemeMode.light)).called(1);
    });
  });
}
