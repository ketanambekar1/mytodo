import 'package:flutter/material.dart';
import 'package:mytodo/db/priority_operations/priority_services.dart';

class PriorityView extends StatelessWidget {
  final PriorityService priorityService = PriorityService();

  PriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    final priorities = priorityService.getPriorities();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Priorities'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: priorities.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final priority = priorities[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('Q${priority.quadrant}'),
              backgroundColor: _getQuadrantColor(priority.quadrant),
            ),
            title: Text(priority.name),
            subtitle: Text('Quadrant ${priority.quadrant}'),
          );
        },
      ),
    );
  }

  Color _getQuadrantColor(int q) {
    switch (q) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}
