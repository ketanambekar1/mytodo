import 'package:get_storage/get_storage.dart';
import 'package:mytodo/constants/app_constants.dart';
import 'package:mytodo/db/priority_operations/priority_models.dart';

class PriorityService {
  final _storage = GetStorage();
  final _key = AppConstants.priorityListKey;

  List<Priority> getPriorities() {
    final raw = _storage.read<List>(_key) ?? [];
    return raw.map((e) => Priority.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  void savePriorities(List<Priority> priorities) {
    _storage.write(_key, priorities.map((e) => e.toJson()).toList());
  }

  void initializeDefaultPriorities() {
    if (!_storage.hasData(_key)) {
      final priorities = [
        Priority(id: 'q1', name: 'Urgent & Important', quadrant: 1),
        Priority(id: 'q2', name: 'Important, Not Urgent', quadrant: 2),
        Priority(id: 'q3', name: 'Urgent, Not Important', quadrant: 3),
        Priority(id: 'q4', name: 'Neither Urgent nor Important', quadrant: 4),
      ];
      savePriorities(priorities);
    }
  }
}
