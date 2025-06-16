import 'package:get/get.dart';
import 'package:mytodo/db/todo_operations/todo_model.dart';
import 'package:mytodo/db/todo_operations/todo_service.dart';

class DashboardController extends GetxController {
  final ToDoService _service = ToDoService();

  RxList<ToDo> todos = <ToDo>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadToDos();
  }

  void loadToDos() {
    todos.value = _service.getToDos();
  }

  void addToDo(String title, String description, String priority, DateTime? dueDate) {
    final newToDo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isDone: false,
      createdAt: DateTime.now(),
      // priority: priority,
      // dueDate: dueDate,
    );
    _service.addToDo(newToDo);
    loadToDos();
  }

  void toggleToDo(String id) {
    _service.toggleDone(id);
    loadToDos();
  }

  void deleteToDo(String id) {
    _service.deleteToDo(id);
    loadToDos();
  }
}
