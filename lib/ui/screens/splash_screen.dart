import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mbinu/ui/screens/auth/email_verification_screen.dart';
import 'package:mbinu/ui/screens/main_screen.dart';
import 'package:mbinu/ui/state_holders/auth/auth_controller.dart';
import 'package:mbinu/ui/utils/images_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotToNextScreen();
    super.initState();
  }

  Future<void> gotToNextScreen() async {
    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) =>
          AuthController.isLogin
              ? Get.offAll(const MainScreen())
              : Get.to(const EmailVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SvgPicture.asset(ImagesUtils.mbinuStoreLogoSVG, width: 100),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          SizedBox(height: 10),
          const Text(
            "Developed By Obuya Erick",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 10),
          const Text("Version 1.0.0"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
