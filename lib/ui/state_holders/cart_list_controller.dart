import 'package:get/get.dart';
import 'package:mbinu/data/models/cart_item.dart';
import 'package:mbinu/data/models/cart_list_model.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class CartListController extends GetxController {
  bool _cartListInProgress = false;
  CartListModel _cartListModel = CartListModel();
  double _totalPrice = 0;
  String _message = '';

  bool get cartListInProgress => _cartListInProgress;
  CartListModel get cartListModel => _cartListModel;
  double get totalPrice => _totalPrice;
  String get message => _message;
  bool get cartIsEmpty => _cartListModel.data?.isEmpty ?? true;

  Future<bool> getCartList() async {
    _cartListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getCartList,
    );
    _cartListInProgress = false;
    update();
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseJson!);
      _calculateTotalPrice();
      return true;
    } else {
      _message = "Cart list fetch failed!";
      return false;
    }
  }

  bool removeCartItem(int productId) {
    int productIndex =
        _cartListModel.data?.indexWhere(
          (cartItem) => cartItem.productId == productId,
        ) ??
        -1;
    if (productIndex >= 0) {
      _cartListModel.data?.removeAt(productIndex);
      _calculateTotalPrice();
      return true;
    }
    return false;
  }

  void changeItem(int productId, int quantity) {
    _cartListModel
        .data
        ?.firstWhere((cartItem) => cartItem.id == productId)
        .quantity = quantity;
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (CartItem cartItem in _cartListModel.data ?? []) {
      _totalPrice +=
          (cartItem.quantity *
              (double.tryParse(cartItem.product?.price ?? '0') ?? 0));
    }
    update();
  }
}
