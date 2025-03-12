import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/ui/state_holders/categories_controller.dart';
import 'package:mbinu/ui/state_holders/main_screen_controller.dart';
import 'package:mbinu/ui/widgets/category_card.dart';
import 'package:mbinu/ui/widgets/custom_app_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: customAppBar("Categories", false),
        body: gridViewForCategories,
      ),
      onPopInvokedWithResult: (_, _) async {
        Get.find<MainScreenController>().backToHomeScreen();
      },
    );
  }

  Padding get gridViewForCategories {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CategoriesController>(
        builder: (categoriesController) {
          if (categoriesController.categoriesInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            itemCount: categoriesController.categoryModel.data?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, int index) {
              return FittedBox(
                child: CategoryCard(
                  categoryData: categoriesController.categoryModel.data![index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
