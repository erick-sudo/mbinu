import 'package:get/get.dart';
import 'package:mbinu/ui/state_holders/add_to_cart_controller.dart';
import 'package:mbinu/ui/state_holders/auth/complete_profile_controller.dart';
import 'package:mbinu/ui/state_holders/auth/email_verification_controller.dart';
import 'package:mbinu/ui/state_holders/auth/verify_login_controller.dart';
import 'package:mbinu/ui/state_holders/cart_list_controller.dart';
import 'package:mbinu/ui/state_holders/categories_controller.dart';
import 'package:mbinu/ui/state_holders/create_wish_list_controller.dart';
import 'package:mbinu/ui/state_holders/home_screen_slider_controller.dart';
import 'package:mbinu/ui/state_holders/main_screen_controller.dart';
import 'package:mbinu/ui/state_holders/new_products_controller.dart';
import 'package:mbinu/ui/state_holders/popular_products_controller.dart';
import 'package:mbinu/ui/state_holders/product_details_controller.dart';
import 'package:mbinu/ui/state_holders/products_wish_list_controller.dart';
import 'package:mbinu/ui/state_holders/read_profile_controller.dart';
import 'package:mbinu/ui/state_holders/special_products_controller.dart';

class StateHoldersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainScreenController());
    Get.put(EmailVerificationController());
    Get.put(OTPVerifyLoginController());
    Get.put(HomeScreenSliderController());
    Get.put(CategoriesController());
    Get.put(PopularProductsController());
    Get.put(NewProductsController());
    Get.put(SpecialProductsController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(CompleteProfileController());
    Get.put(CartListController());
    Get.put(ProductsWishListController());
    Get.put(CreateWishListController());
    // Get.put(ReviewListController());
    // Get.put(CreateReviewController());
    Get.put(ReadProfileController());
    // Get.put(DeleteCartListController());
  }
}
