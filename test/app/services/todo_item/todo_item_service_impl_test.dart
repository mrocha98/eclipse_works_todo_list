import 'package:eclipse_works_todo_list/app/models/todo_item_model.dart';
import 'package:eclipse_works_todo_list/app/repositories/todo_list/todo_item_repository.dart';
import 'package:eclipse_works_todo_list/app/services/todo_item/todo_item_service_impl.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TodoItemRepositoryMock extends Mock implements TodoItemRepository {}

void main() {
  late TodoItemServiceImpl sut;
  late TodoItemRepositoryMock todoItemRepositoryMock;
  final faker = Faker.instance;

  setUp(() {
    todoItemRepositoryMock = TodoItemRepositoryMock();
    sut = TodoItemServiceImpl(todoItemRepositoryMock);
  });

  group('.create', () {
    test(
      'should call TodoItemRepository.save with falsy isDone by default',
      () async {
        final content = faker.lorem.sentence();
        when(() => todoItemRepositoryMock.create(content))
            .thenAnswer((_) async {});

        await sut.create(content);

        verify(() => todoItemRepositoryMock.create(content)).called(1);
      },
    );

    test('should call TodoItemRepository.save with truthy isDone', () async {
      final content = faker.lorem.sentence();
      when(() => todoItemRepositoryMock.create(content, isDone: true))
          .thenAnswer((_) async {});

      await sut.create(content, isDone: true);

      verify(() => todoItemRepositoryMock.create(content, isDone: true))
          .called(1);
    });
  });

  group('.delete', () {
    test('should call TodoItemRepository.delete', () async {
      final id = faker.datatype.uuid();
      when(() => todoItemRepositoryMock.delete(id)).thenAnswer((_) async {});

      await sut.delete(id);

      verify(() => todoItemRepositoryMock.delete(id)).called(1);
    });
  });

  group('.getAll', () {
    test('should call TodoItemRepository.getAll', () async {
      final expectedList = [
        TodoItemModel(
          id: faker.datatype.uuid(),
          content: faker.lorem.sentence(),
          isDone: faker.datatype.boolean(),
          createdAt: faker.datatype.dateTime(),
        ),
      ];
      when(() => todoItemRepositoryMock.getAll())
          .thenAnswer((_) async => expectedList);

      final list = await sut.getAll();

      expect(list, expectedList);
    });
  });
}
