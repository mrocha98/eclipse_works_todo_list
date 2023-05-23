import 'package:eclipse_works_todo_list/app/core/database/key_value_storage/key_value_storage.dart';
import 'package:eclipse_works_todo_list/app/repositories/theme_mode/theme_mode_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class KeyValueStorageMockImpl extends Mock implements KeyValueStorage {}

void main() {
  late ThemeModeRepositoryImpl sut;
  late KeyValueStorageMockImpl keyValueStorageMock;

  setUp(() {
    keyValueStorageMock = KeyValueStorageMockImpl();
    sut = ThemeModeRepositoryImpl(keyValueStorageMock);
  });

  group('.getThemeMode', () {
    test('when there is no ThemeMode cached should return null', () async {
      when(() => keyValueStorageMock.get<String>('theme_mode'))
          .thenAnswer((_) async => null);

      final themeMode = await sut.getThemeMode();

      expect(themeMode, isNull);
    });

    test('when there is a ThemeMode cached should return it', () async {
      when(() => keyValueStorageMock.get<String>('theme_mode'))
          .thenAnswer((_) async => ThemeMode.dark.name);

      final themeMode = await sut.getThemeMode();

      expect(themeMode, ThemeMode.dark);
    });
  });

  group('.save', () {
    test(
      'should call KeyValueStorage.set using "theme_mode" as key and '
      'ThemeMode.dark.name as value',
      () async {
        when(() => keyValueStorageMock.set('theme_mode', ThemeMode.dark.name))
            .thenAnswer((_) async {});

        await sut.save(ThemeMode.dark);

        verify(() => keyValueStorageMock.set('theme_mode', ThemeMode.dark.name))
            .called(1);
      },
    );
  });
}
