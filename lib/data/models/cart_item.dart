import 'package:mbinu/data/models/product.dart';

class CartItem {
  int? id;
  String? email;
  int? productId;
  String? color;
  String? size;
  String? createdAt;
  String? updatedAt;
  Product? product;
  int quantity = 1;

  CartItem({
    this.id,
    this.email,
    this.productId,
    this.color,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['productId'];
    color = json['color'];
    size = json['size'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['productId'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['product'] = product?.toJson();
    return data;
  }
}
