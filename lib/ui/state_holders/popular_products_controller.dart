import 'package:get/get.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/models/products_model.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class PopularProductsController extends GetxController {
  bool _getPopularProductsInProgress = false;
  String _message = "";
  ProductModel _productModel = ProductModel();

  bool get getPopularProductsInProgress => _getPopularProductsInProgress;

  ProductModel get productModel => _productModel;

  String get message => _message;

  Future<bool> getPopularProducts() async {
    _getPopularProductsInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getProductsByRemarks('popular'),
    );
    _getPopularProductsInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _productModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Popular products get failed';
      update();
      return false;
    }
  }
}
