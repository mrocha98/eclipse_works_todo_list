import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class TodoItemModel {
  const TodoItemModel({
    required this.id,
    required this.content,
    required this.isDone,
    required this.createdAt,
  });

  factory TodoItemModel.fromMap(Map<String, dynamic> map) {
    return TodoItemModel(
      id: map['id'] as String,
      content: map['content'] as String,
      isDone: map['isDone'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  factory TodoItemModel.fromJson(String source) =>
      TodoItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;

  final String content;

  final bool isDone;

  final DateTime createdAt;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoItemModel &&
        other.id == id &&
        other.content == content &&
        other.isDone == isDone &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^ content.hashCode ^ isDone.hashCode ^ createdAt.hashCode;

  TodoItemModel copyWith({
    String? id,
    String? content,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TodoItemModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'TodoItemModel('
      'id: $id, '
      'content: $content, '
      'isDone: $isDone, '
      'createdAt: $createdAt'
      ')';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isDone': isDone,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
