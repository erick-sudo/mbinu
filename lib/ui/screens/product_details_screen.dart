import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/data/models/product_details.dart';
import 'package:mbinu/ui/state_holders/add_to_cart_controller.dart';
import 'package:mbinu/ui/state_holders/create_wish_list_controller.dart';
import 'package:mbinu/ui/state_holders/product_details_controller.dart';
import 'package:mbinu/ui/utils/app_color.dart';
import 'package:mbinu/ui/widgets/custom_app_bar.dart';
import 'package:mbinu/ui/widgets/custom_stepper.dart';
import 'package:mbinu/ui/widgets/favorite_icon_button.dart';
import 'package:mbinu/ui/widgets/product_details_screen_widgets/product_details_color_selector.dart';
import 'package:mbinu/ui/widgets/product_details_screen_widgets/product_details_size_selector.dart';
import 'package:mbinu/ui/widgets/products_carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductsDetails(widget.productId);
      Get.find<ProductDetailsController>().availableColors.clear();
    });
  }

  // ignore: unused_field
  int _selectedSizeIndex = 0;
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Products Details", true),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if (productDetailsController.getProductsDetailsInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              ProductDetailsCarouselSlider(
                imageList: [
                  productDetailsController.productDetails.img1 ?? "",
                  productDetailsController.productDetails.img2 ?? "",
                  productDetailsController.productDetails.img3 ?? "",
                  productDetailsController.productDetails.img4 ?? "",
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: productsDetails(
                      productDetailsController.productDetails,
                      productDetailsController.availableColors,
                    ),
                  ),
                ),
              ),
              cartBottomContainer(
                productDetailsController.productDetails,
                productDetailsController.availableColors,
                productDetailsController.availableSizes,
              ),
            ],
          );
        },
      ),
    );
  }

  Column productsDetails(ProductDetails productsDetails, List<String> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                productsDetails.product?.title ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
            ),
            CustomStepper(
              stepValue: 1,
              lowerLimit: 1,
              upperLimit: 20,
              value: 1,
              onChanged: (value) {},
            ),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.star, size: 18, color: Colors.amber),
            Text(
              '${productsDetails.product?.star ?? ""}',
              style: const TextStyle(
                fontSize: 15,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
            TextButton(
              onPressed: () {
                // Get.to(
                //   () =>
                //       ReviewsScreen(productsId: productsDetails.productId ?? 0),
                // );
              },
              child: const Text(
                "Review",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
            InkWell(
              onTap: () {
                Get.find<CreateWishListController>().createWishList(
                  productsDetails.productId!,
                );
              },
              child: const FavoriteIconButton(),
            ),
          ],
        ),
        const Text(
          "Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        ProductDetailsColorSelector(
          colors: colors,
          selectedColor: _selectedColorIndex,
          onSelected: (int index) {
            _selectedColorIndex = index;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          "Sizes",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        ProductDetailsSizeSelector(
          sizes: productsDetails.size?.split(',') ?? [],
          onSelect: (int index) {
            _selectedSizeIndex = index;
          },
          initialSelected: 0,
        ),
        const SizedBox(height: 16),
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(productsDetails.des ?? "", textAlign: TextAlign.justify),
      ],
    );
  }

  Container cartBottomContainer(
    ProductDetails productsDetails,
    List<String> color,
    List<String> size,
  ) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        color: AppColor.primaryColor.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Price", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(
                  '${productsDetails.product?.price ?? 0}',
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
              child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  if (addToCartController.addToCartInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      final results = await addToCartController.addToCart(
                        productsDetails.id!,
                        color[_selectedColorIndex].toString(),
                        size[_selectedSizeIndex].toString(),
                      );

                      if (results) {
                        Get.snackbar("Success", "Add to cart success");
                        // log(color[_selectedColorIndex]);
                        // log(size[_selectedSizeIndex]);
                      }
                      //else if (AuthController.accessToken!.isEmpty) {
                      //   Get.defaultDialog(
                      //       title: "Login",
                      //       content: const Text(
                      //           "To confirm your order, you need to login first"),
                      //       onCancel: () {
                      //         Get.back();
                      //       },
                      //       onConfirm: () {
                      //         AuthController.clear();
                      //       });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 13),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
