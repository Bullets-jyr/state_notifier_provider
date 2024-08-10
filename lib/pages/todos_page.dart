import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todos_provider.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    print(todos);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          const AddTodo(),
          const SizedBox(height: 20),
          // ListView위젯이 Column위젯 내에 있게 되면 둘다
          // unbounded height를 가지게 되기 때문에
          // lender overflow에러가 발생합니다.
          // 이를 방지하기 위해서 ListView위젯을 Expanded위젯으로 감싸겠습니다.
          // Column + ListView = unbounded height, lender overflow
          Expanded(
            child: ListView(
              // collection for-loop
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                    // Checkbox가 앞쪽에 표시되도록 하겠습니다.
                    controlAffinity: ListTileControlAffinity.leading,
                    value: todo.completed,
                    onChanged: (value) {
                      ref.read(todosProvider.notifier).toggleTodo(todo.id);
                    },
                    title: Text(todo.desc),
                    secondary: IconButton(
                      onPressed: () {
                        ref.read(todosProvider.notifier).removeTodo(todo.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: textController,
        decoration: const InputDecoration(
          labelText: 'New Todo',
        ),
        onSubmitted: (desc) {
          if (desc.isNotEmpty) {
            ref.read(todosProvider.notifier).addTodo(desc);
            textController.clear();
          }
        },
      ),
    );
  }
}