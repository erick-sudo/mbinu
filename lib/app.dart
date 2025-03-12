import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbinu/state_holders_bindings.dart';
import 'package:mbinu/ui/screens/splash_screen.dart';
import 'package:mbinu/ui/utils/app_color.dart';

class MbinuStore extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey();

  const MbinuStore({super.key});

  @override
  State<MbinuStore> createState() => _MbinuStoreState();
}

class _MbinuStoreState extends State<MbinuStore> {
  @override
  void initState() {
    super.initState();
  }

  void checkInitialInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    handleConnectivityStates(result);
  }

  void handleConnectivityStates(List<ConnectivityResult> states) {
    if (states.isNotEmpty && states[0] == ConnectivityResult.none) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "No internet!",
          message: "Please check your internet connectivity",
          isDismissible: false,
        ),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Mbinu-Store",
      navigatorKey: MbinuStore.globalKey,
      locale: DevicePreview.locale(context), //for devices preview
      builder: DevicePreview.appBuilder,
      initialBinding: StateHoldersBindings(),
      debugShowCheckedModeBanner: false, //
      home: const SplashScreen(),
      theme: ThemeData(
        primarySwatch: MaterialColor(
          AppColor.primaryColor.value,
          AppColor().color,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}
