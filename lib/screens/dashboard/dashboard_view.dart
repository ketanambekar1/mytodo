import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/screens/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tasks = controller.todos;
      if (tasks.isEmpty) {
        return const Center(child: Text("No tasks. Add some!"));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (_, i) {
          final task = tasks[i];
          return Card(
            child: ListTile(
              leading: Checkbox(
                value: task.isDone,
                onChanged: (_) => controller.toggleToDo(task.id),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task.description.isNotEmpty) Text(task.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (task.createdAt != null)
                    Text(
                      "Due: ${DateFormat.yMMMd().format(task.createdAt!)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteToDo(task.id),
              ),
            ),
          );
        },
      );
    });
  }
}
