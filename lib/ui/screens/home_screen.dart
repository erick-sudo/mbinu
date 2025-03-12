import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mbinu/ui/screens/auth/email_verification_screen.dart';
import 'package:mbinu/ui/screens/items_screen.dart';
import 'package:mbinu/ui/state_holders/categories_controller.dart';
import 'package:mbinu/ui/state_holders/home_screen_slider_controller.dart';
import 'package:mbinu/ui/state_holders/main_screen_controller.dart';
import 'package:mbinu/ui/state_holders/new_products_controller.dart';
import 'package:mbinu/ui/state_holders/popular_products_controller.dart';
import 'package:mbinu/ui/state_holders/special_products_controller.dart';
import 'package:mbinu/ui/utils/images_utils.dart';
import 'package:mbinu/ui/widgets/app_bar_icon.dart';
import 'package:mbinu/ui/widgets/category_card.dart';
import 'package:mbinu/ui/widgets/home_screen_widgets/home_screen_search_bar.dart';
import 'package:mbinu/ui/widgets/home_screen_widgets/home_slider.dart';
import 'package:mbinu/ui/widgets/product_card.dart';
import 'package:mbinu/ui/widgets/shimmer/shimmer_popular_products.dart';
import 'package:mbinu/ui/widgets/shimmer/shimmer_progress_for_carousel_slider.dart';
import 'package:mbinu/ui/widgets/title_header_and_see_all_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeScreenAppBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const HomeScreenSearchBar(),
              const SizedBox(height: 16),
              GetBuilder<HomeScreenSliderController>(
                builder: (controller) {
                  if (controller.homeScreenSliderInProgress) {
                    return const SizedBox(
                      height: 200,
                      child: ShimmerProgressForCarouselSlider(),
                    );
                  }
                  return HomeSlider(
                    sliders: controller.homeScreenSliderModel.data ?? [],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Product categories
              TitleHeaderAndSeeAllButton(
                title: 'All Categories',
                onTap: () {
                  Get.find<MainScreenController>().onChanged(1);
                },
              ),
              const SizedBox(height: 8),
              allCategoriesCardListView,

              // Popular products
              GetBuilder<PopularProductsController>(
                builder: (controller) {
                  return TitleHeaderAndSeeAllButton(
                    title: "Popular",
                    onTap: () {
                      Get.to(
                        ItemsScreen(
                          title: 'Popular',
                          products: controller.productModel,
                        ),
                      );
                    },
                  );
                },
              ),
              popularProductsListView,

              // Special products
              GetBuilder<SpecialProductsController>(
                builder: (specialProductsController) {
                  return TitleHeaderAndSeeAllButton(
                    title: "Special",
                    onTap: () {
                      Get.to(
                        ItemsScreen(
                          title: 'Special',
                          products: specialProductsController.productModel,
                        ),
                      );
                    },
                  );
                },
              ),
              specialProductsListView,

              // New products
              GetBuilder<NewProductsController>(
                builder: (newProductsController) {
                  return TitleHeaderAndSeeAllButton(
                    title: "New",
                    onTap: () {
                      Get.to(
                        ItemsScreen(
                          title: 'New',
                          products: newProductsController.productModel,
                        ),
                      );
                    },
                  );
                },
              ),
              newProductsListView,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get newProductsListView {
    return SizedBox(
      height: 182,
      child: GetBuilder<NewProductsController>(
        builder: (newProductsController) {
          if (newProductsController.getNewProductsInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            addAutomaticKeepAlives: true,
            scrollDirection: Axis.horizontal,
            itemCount: newProductsController.productModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ProductCard(
                product: newProductsController.productModel.data![index],
                isShowDeleteButton: false,
              );
            },
          );
        },
      ),
    );
  }

  SizedBox get specialProductsListView {
    return SizedBox(
      height: 182,
      child: GetBuilder<SpecialProductsController>(
        builder: (specialProductsController) {
          if (specialProductsController.getSpecialProductsInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            addAutomaticKeepAlives: true,
            scrollDirection: Axis.horizontal,
            itemCount: specialProductsController.productModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ProductCard(
                product: specialProductsController.productModel.data![index],
                isShowDeleteButton: false,
              );
            },
          );
        },
      ),
    );
  }

  SizedBox get popularProductsListView {
    return SizedBox(
      height: 182,
      child: GetBuilder<PopularProductsController>(
        builder: (popularProductsController) {
          if (popularProductsController.getPopularProductsInProgress) {
            return const Row(
              children: [
                ShimmerPopularProducts(height: 160, width: 150),
                ShimmerPopularProducts(height: 160, width: 150),
              ],
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularProductsController.productModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ProductCard(
                product: popularProductsController.productModel.data![index],
                isShowDeleteButton: false,
              );
            },
          );
        },
      ),
    );
  }

  SizedBox get allCategoriesCardListView {
    return SizedBox(
      height: 90,
      child: GetBuilder<CategoriesController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.categoryModel.data?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryCard(
                categoryData: controller.categoryModel.data![index],
              );
            },
          );
        },
      ),
    );
  }

  AppBar get homeScreenAppBar {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          SvgPicture.asset(ImagesUtils.mbinuStoreNavBarLogoSVG),
          const Spacer(),
          AppBarIcon(
            icon: Icons.person_outline,
            onTap: () {
              Get.to(() => const EmailVerificationScreen());
            },
          ),
          const SizedBox(width: 12),
          AppBarIcon(icon: Icons.phone_outlined, onTap: () {}),
          const SizedBox(width: 12),
          AppBarIcon(icon: Icons.notifications_active_outlined, onTap: () {}),
        ],
      ),
    );
  }
}
