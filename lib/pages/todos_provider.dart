import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_model.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);

  // business logic
  void addTodo(String desc) {
    // spread operator: ...
    state = [...state, Todo.add(desc: desc)];
    // StateNotifier에서는 state를 직접 mutation(mutate)하면 안됩니다. (UI에 반영안됨)
    // state.add(Todo.add(desc: desc));
    // print('in addTodo: $state');
  }

  void toggleTodo(String id) {
    // collection for-loop
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
    ];
  }

  void removeTodo(String id) {
    // collection for-loop
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
// final todosProvider = StateNotifierProvider.autoDispose<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});