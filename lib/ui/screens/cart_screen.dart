import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/data/models/cart_list_model.dart';
import 'package:mbinu/ui/state_holders/cart_list_controller.dart';
import 'package:mbinu/ui/utils/app_color.dart';
import 'package:mbinu/ui/widgets/cart_item_card.dart';
import 'package:mbinu/ui/widgets/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  final CartListModel data = CartListModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Cart", false),
      body: GetBuilder<CartListController>(
        builder: (cartListController) {
          if (cartListController.cartListInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartListController.cartIsEmpty) {
            return Center(
              child: Text(
                "Cart is empty, please add some products",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.purpleAccent,
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartListController.cartListModel.data?.length ?? 0,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CartItemCard(
                        cartItem: cartListController.cartListModel.data![index],
                      ),
                    );
                  },
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  color: AppColor.primaryColor.withValues(alpha: 0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "\$ ${cartListController.totalPrice}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Check Out",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
