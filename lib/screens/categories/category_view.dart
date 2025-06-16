import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/db/category_operations/category_models.dart';
import 'package:mytodo/db/category_operations/category_services.dart';
import 'package:mytodo/theme/app_colors.dart';

class CategoryView extends StatelessWidget {
  final CategoryService categoryService = CategoryService();

  CategoryView({super.key});

  void _showCategoryDialog(BuildContext context, {Category? category}) {
    final TextEditingController controller = TextEditingController(
      text: category?.name ?? '',
    );

    final isEdit = category != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? "Edit Category" : "Add Category",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Category name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isNotEmpty) {
                    if (isEdit) {
                      categoryService.updateCategory(
                        category!.copyWith(name: name),
                      );
                      Get.snackbar('Updated', '$name updated');
                    } else {
                      categoryService.addCategory(Category(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: name,
                      ));
                      Get.snackbar('Added', '$name added');
                    }
                    Navigator.pop(context);
                    Get.forceAppUpdate();
                  }
                },
                child: Text(isEdit ? "Update" : "Add"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = categoryService.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            leading: const Icon(Icons.label),
            title: Text(cat.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _showCategoryDialog(context, category: cat),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    categoryService.deleteCategory(cat.id);
                    Get.snackbar('Deleted', '${cat.name} removed');
                    Get.forceAppUpdate();
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => _showCategoryDialog(context),
          child: Container(
            width: double.maxFinite,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: const Text(
              "Add A New Category",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
