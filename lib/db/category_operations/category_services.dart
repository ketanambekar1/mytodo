import 'package:get_storage/get_storage.dart';
import 'package:mytodo/constants/app_constants.dart';
import 'package:mytodo/db/category_operations/category_models.dart';

class CategoryService {
  final _storage = GetStorage();
  final _key = AppConstants.categoryListKey;

  List<Category> getCategories() {
    final raw = _storage.read<List>(_key) ?? [];
    return raw.map((e) => Category.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  void saveCategories(List<Category> categories) {
    _storage.write(_key, categories.map((e) => e.toJson()).toList());
  }

  void addCategory(Category cat) {
    final all = getCategories();
    all.add(cat);
    saveCategories(all);
  }

  void deleteCategory(String id) {
    final all = getCategories();
    all.removeWhere((c) => c.id == id);
    saveCategories(all);
  }

  void updateCategory(Category updatedCat) {
    final all = getCategories();
    final index = all.indexWhere((c) => c.id == updatedCat.id);
    if (index != -1) {
      all[index] = updatedCat;
      saveCategories(all);
    }
  }

  void initializeDefaultCategories() {
    if (!_storage.hasData(_key)) {
      final defaultCats = [
        Category(id: DateTime.now().millisecondsSinceEpoch.toString(), name: 'Work'),
        Category(id: (DateTime.now().millisecondsSinceEpoch + 1).toString(), name: 'Personal'),
        Category(id: (DateTime.now().millisecondsSinceEpoch + 2).toString(), name: 'Shopping'),
        Category(id: (DateTime.now().millisecondsSinceEpoch + 3).toString(), name: 'Urgent'),
      ];
      saveCategories(defaultCats);
    }
  }
}
