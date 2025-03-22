import 'package:flutter/material.dart';
import 'package:mbinu/data/models/category_data.dart';
import 'package:mbinu/ui/utils/app_color.dart';

class CategoryCard extends StatelessWidget {
  final CategoryData categoryData;
  const CategoryCard({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(categoryData.categoryImg ?? "", height: 50),
          ),
          const SizedBox(height: 4),
          Text(
            categoryData.categoryName ?? "",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              // fontSize: 15,
              color: AppColor.primaryColor,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
