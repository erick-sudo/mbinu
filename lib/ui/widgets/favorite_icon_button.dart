import 'package:flutter/material.dart';
import 'package:mbinu/ui/utils/app_color.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: AppColor.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Icon(Icons.favorite_border, size: 16, color: Colors.white),
      ),
    );
  }
}
