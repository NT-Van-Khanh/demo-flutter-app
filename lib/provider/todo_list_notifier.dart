import 'package:b1_first_flutter_app/data/model/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [];

  void add(String title) {
    state = [
      ...state,
      Todo(id: DateTime.now().toString(), title: title),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isDone: !todo.isDone)
        else
          todo
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
