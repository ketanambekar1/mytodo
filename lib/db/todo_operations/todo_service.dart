import 'package:get_storage/get_storage.dart';
import 'package:mytodo/constants/app_constants.dart';
import 'package:mytodo/db/todo_operations/todo_model.dart';

class ToDoService {
  final _storage = GetStorage();
  final _key = AppConstants.todoListKey;

  List<ToDo> getToDos() {
    final raw = _storage.read<List>(_key) ?? [];
    return raw.map((e) => ToDo.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  void saveToDos(List<ToDo> todos) {
    _storage.write(_key, todos.map((e) => e.toJson()).toList());
  }

  void addToDo(ToDo todo) {
    final todos = getToDos();
    todos.add(todo);
    saveToDos(todos);
  }

  void updateToDo(ToDo updated) {
    final todos = getToDos();
    final index = todos.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      todos[index] = updated;
      saveToDos(todos);
    }
  }

  void deleteToDo(String id) {
    final todos = getToDos();
    todos.removeWhere((t) => t.id == id);
    saveToDos(todos);
  }

  void toggleDone(String id) {
    final todos = getToDos();
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index].isDone = !todos[index].isDone;
      saveToDos(todos);
    }
  }
}
