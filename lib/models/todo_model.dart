import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.freezed.dart';

Uuid uuid = const Uuid();

@freezed
class Todo with _$Todo {
  const factory Todo({
    // 그렇지만 default value로 runtime에 값이 정해지는 value를 줄 순 없습니다.
    required String id,
    required String desc,
    @Default(false) bool completed,
  }) = _Todo;

  // 새로운 todo를 add할 때 사용할 factory constructor를 하나 더 만들면 됩니다.
  // factory constructor
  factory Todo.add({required String desc}) {
    return Todo(id: uuid.v4(), desc: desc);
  }
}