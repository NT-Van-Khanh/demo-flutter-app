import 'package:b1_first_flutter_app/model/todo.dart';
import 'package:b1_first_flutter_app/provider/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final todoListProvider = NotifierProvider<TodoListNotifier, List<Todo>>(() {
  return TodoListNotifier();
});


class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Column(
        children: [
          // Input thêm todo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Nhập việc cần làm...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
        
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ref.read(todoListProvider.notifier).add(controller.text);
                      controller.clear();
                    }
                  },
                  style: IconButton.styleFrom(
                    // backgroundColor: Colors.blue.shade50,    
                    side: const BorderSide(color: Color.fromARGB(255, 123, 123, 123), width: 2), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
            ),
                )
              ],
            ),
          ),
          const Divider(),
         Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) {
                            ref.read(todoListProvider.notifier).toggle(todo.id);
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref.read(todoListProvider.notifier).remove(todo.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
