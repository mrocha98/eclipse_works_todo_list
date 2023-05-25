import 'package:clock/clock.dart';
import 'package:eclipse_works_todo_list/app/core/database/id_generator/id_generator.dart';
import 'package:eclipse_works_todo_list/app/core/database/key_value_storage/key_value_storage.dart';
import 'package:eclipse_works_todo_list/app/models/todo_item_model.dart';
import 'package:eclipse_works_todo_list/app/repositories/todo_list/todo_item_repository_impl.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class KeyValueStorageMock extends Mock implements KeyValueStorage {}

class IdGeneratorMock extends Mock implements IdGenerator {}

TodoItemModel createFakeTodoItemModel() {
  final faker = Faker.instance;
  return TodoItemModel(
    id: faker.datatype.uuid(),
    content: faker.lorem.sentence(),
    isDone: faker.datatype.boolean(),
    createdAt: faker.datatype.dateTime(),
  );
}

void main() {
  late TodoItemRepositoryImpl sut;
  late KeyValueStorageMock keyValueStorageMock;
  late IdGeneratorMock idGeneratorMock;
  const todoListKey = 'todo_list';
  final faker = Faker.instance;

  setUp(() {
    keyValueStorageMock = KeyValueStorageMock();
    idGeneratorMock = IdGeneratorMock();
    sut = TodoItemRepositoryImpl(
      keyValueStorageMock,
      idGeneratorMock,
    );
  });

  group('.create', () {
    late String id;
    late String content;
    late DateTime now;

    setUp(() {
      id = faker.datatype.uuid();
      content = faker.lorem.sentence();
      now = faker.datatype.dateTime();
    });

    test('should create a TodoItemModel with falsy isDone by default', () {
      withClock(Clock.fixed(now), () async {
        final model = TodoItemModel(
          id: id,
          content: content,
          isDone: false,
          createdAt: now,
        );
        when(() => keyValueStorageMock.getStringList(todoListKey))
            .thenAnswer((_) async => const []);
        when(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model.toJson()],
          ),
        ).thenAnswer((_) async {});
        when(() => idGeneratorMock.generate()).thenReturn(id);

        await sut.create(content);

        verify(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model.toJson()],
          ),
        ).called(1);
      });
    });

    test('should create a TodoItemModel with truthy isDone', () {
      withClock(Clock.fixed(now), () async {
        final model = TodoItemModel(
          id: id,
          content: content,
          isDone: true,
          createdAt: now,
        );
        when(() => keyValueStorageMock.getStringList(todoListKey))
            .thenAnswer((_) async => const []);
        when(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model.toJson()],
          ),
        ).thenAnswer((_) async {});
        when(() => idGeneratorMock.generate()).thenReturn(id);

        await sut.create(content, isDone: true);

        verify(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model.toJson()],
          ),
        ).called(1);
      });
    });

    test('should generate id using IdGenerator', () {
      withClock(Clock.fixed(now), () async {
        when(() => keyValueStorageMock.getStringList(todoListKey))
            .thenAnswer((_) async => const []);
        when(
          () => keyValueStorageMock.setStringList(any(), any()),
        ).thenAnswer((_) async {});
        when(() => idGeneratorMock.generate()).thenReturn(id);

        await sut.create(content);

        verify(() => idGeneratorMock.generate()).called(1);
      });
    });

    test(
      'should append new TodoItemModel as first item in existent list',
      () {
        withClock(Clock.fixed(now), () async {
          final model = TodoItemModel(
            id: id,
            content: content,
            isDone: false,
            createdAt: now,
          );
          final existentModel = model.copyWith(isDone: true);
          when(() => keyValueStorageMock.getStringList(todoListKey))
              .thenAnswer((_) async => [existentModel.toJson()]);
          when(
            () => keyValueStorageMock.setStringList(
              todoListKey,
              [model.toJson(), existentModel.toJson()],
            ),
          ).thenAnswer((_) async {});
          when(() => idGeneratorMock.generate()).thenReturn(id);

          await sut.create(content);

          verify(
            () => keyValueStorageMock.setStringList(
              todoListKey,
              [model.toJson(), existentModel.toJson()],
            ),
          ).called(1);
        });
      },
    );
  });

  group('.delete', () {
    test(
      'when dont find a TodoItemModel with provided id should not change the '
      'existent list',
      () async {
        final model = createFakeTodoItemModel().copyWith(id: '1');
        when(() => keyValueStorageMock.getStringList(todoListKey))
            .thenAnswer((_) async => [model.toJson()]);
        when(() => keyValueStorageMock.setStringList(any(), any()))
            .thenAnswer((_) async {});

        await sut.delete('2');

        verifyNever(() => keyValueStorageMock.setStringList(any(), any()));
      },
    );

    test(
      'when find a TodoItemModel with provided id should remove it from list',
      () async {
        final model1 = createFakeTodoItemModel().copyWith(id: '1');
        final model2 = createFakeTodoItemModel().copyWith(id: '2');
        when(() => keyValueStorageMock.getStringList(todoListKey))
            .thenAnswer((_) async => [model1.toJson(), model2.toJson()]);
        when(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model1.toJson()],
          ),
        ).thenAnswer((_) async {});

        await sut.delete('2');

        verify(
          () => keyValueStorageMock.setStringList(
            todoListKey,
            [model1.toJson()],
          ),
        ).called(1);
      },
    );
  });

  group('.getAll', () {
    test('when existent list is null should return an empty list', () async {
      when(() => keyValueStorageMock.getStringList(todoListKey))
          .thenAnswer((_) async => null);

      final list = await sut.getAll();

      expect(list, isNotNull);
      expect(list, isEmpty);
    });

    test('should return the existent list', () async {
      final existent = [createFakeTodoItemModel(), createFakeTodoItemModel()];
      final existentJsonList =
          existent.map((e) => e.toJson()).toList(growable: false);
      when(() => keyValueStorageMock.getStringList(todoListKey))
          .thenAnswer((_) async => existentJsonList);

      final list = await sut.getAll();

      expect(list, existent);
    });
  });
}
