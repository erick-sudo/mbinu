import 'package:get/get.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/models/products_model.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class SpecialProductsController extends GetxController {
  bool _getSpecialProductsInProgress = false;
  String _message = "";
  ProductModel _productModel = ProductModel();

  bool get getSpecialProductsInProgress => _getSpecialProductsInProgress;

  ProductModel get productModel => _productModel;

  String get message => _message;

  Future<bool> getSpecialProducts() async {
    _getSpecialProductsInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getProductsByRemarks('special'),
    );
    _getSpecialProductsInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _productModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Special products get failed';
      update();
      return false;
    }
  }
}
