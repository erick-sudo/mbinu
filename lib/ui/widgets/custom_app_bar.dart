import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/ui/state_holders/main_screen_controller.dart';
AppBar customAppBar(String title, bool willPopWhenPressTheDefaultBackButton) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      onPressed: () {
        willPopWhenPressTheDefaultBackButton == false ? Get.find<MainScreenController>().backToHomeScreen()
          : Get.back();
        },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    ),
  );
}
