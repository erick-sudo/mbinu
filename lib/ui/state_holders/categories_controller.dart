import 'package:get/get.dart';
import 'package:mbinu/data/models/category_model.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class CategoriesController extends GetxController {
  bool _categoriesInProgress = false;
  bool get categoriesInProgress => _categoriesInProgress;
  CategoryModel _categoryModel = CategoryModel();
  CategoryModel get categoryModel => _categoryModel;

  String _message = '';
  String get message => _message;

  Future<bool> getCategories() async {
    _categoriesInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getCategories,
    );
    _categoriesInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _categoryModel = CategoryModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = "Categories List Fetch Error";
      update();
      return false;
    }
  }
}
