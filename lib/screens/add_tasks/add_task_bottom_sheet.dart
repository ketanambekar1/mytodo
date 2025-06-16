import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/screens/dashboard/dashboard_controller.dart';
import 'package:mytodo/theme/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedPriority = 'Medium';
  DateTime? selectedDate;

  final priorities = ['Low', 'Medium', 'High'];

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _submit() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    if (title.isEmpty) {
      Get.snackbar("Missing Title", "Please enter a task title");
      return;
    }
    Get.find<DashboardController>().addToDo(
      title,
      description,
      selectedPriority ?? 'Medium',
      selectedDate,
    );
    Get.back(); // close sheet
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Add Task", style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              value: selectedPriority,
              items: priorities
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) => setState(() => selectedPriority = val),
              decoration: const InputDecoration(labelText: "Priority"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              selectedDate == null
                  ? "Select Due Date"
                  : DateFormat.yMMMMd().format(selectedDate!),
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: _submit,
              child: const Text("Save Task", style: TextStyle(color: AppColors.white),),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
