import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/data/models/cart_item.dart';
import 'package:mbinu/ui/state_holders/cart_list_controller.dart';
import 'package:mbinu/ui/utils/app_color.dart';
import 'package:mbinu/ui/widgets/custom_stepper.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                  cartItem.product?.image ??
                      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvZXN8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product?.title ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Color: ${cartItem.color ?? ''} ',
                                  ),
                                  TextSpan(text: 'Size: ${cartItem.size}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<CartListController>(
                        builder: (cartListController) {
                          return IconButton(
                            onPressed: () async {
                              bool removed = cartListController
                                  .removeCartItem(cartItem.productId!);
                              if (removed) {
                                Get.snackbar(
                                  "success",
                                  "Product removed from cart successfully",
                                );
                              } else {
                                Get.snackbar(
                                  "failed",
                                  "Failed to remove product from cart",
                                );
                              }
                            },
                            icon: const Icon(Icons.delete_outline),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartItem.product?.price ?? '2000'}',
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 85,
                        child: FittedBox(
                          child: CustomStepper(
                            lowerLimit: 1,
                            upperLimit: 20,
                            stepValue: 1,
                            value: cartItem.quantity,
                            onChanged: (int value) {
                              Get.find<CartListController>().changeItem(
                                cartItem.id!,
                                value,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
