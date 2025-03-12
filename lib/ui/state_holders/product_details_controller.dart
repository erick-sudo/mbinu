import 'package:get/get.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/models/product_details.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class ProductDetailsController extends GetxController {
  bool _getProductsDetailsInProgress = false;
  ProductDetails _productDetails = ProductDetails();
  final List<String> _availableColors = [];
  List<String> _availableSizes = [];
  String _errorMessage = '';

  bool get getProductsDetailsInProgress => _getProductsDetailsInProgress;

  ProductDetails get productDetails => _productDetails;

  List<String> get availableColors => _availableColors;

  List<String> get availableSizes => _availableSizes;

  String get errorMessage => _errorMessage;

  Future<bool> getProductsDetails(int productsId) async {
    _getProductsDetailsInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getProductsDetails(productsId),
    );
    _getProductsDetailsInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _productDetails = ProductDetails.fromJson(response.responseJson ?? {});

      _convertedStringToColor(_productDetails.color ?? "");
      _convertStringToSizes(_productDetails.size ?? "");
      update();
      return true;
    } else {
      _errorMessage = "Could not fetch product details! Please try again.";
      update();
      return false;
    }
  }

  void _convertedStringToColor(String color) {
    final List<String> splittedColor = color.split(',');
    for (String c in splittedColor) {
      if (c.isNotEmpty) {
        _availableColors.add(c);
      }
    }
  }

  void _convertStringToSizes(String sizes) {
    _availableSizes = sizes.split(',');
  }
}
