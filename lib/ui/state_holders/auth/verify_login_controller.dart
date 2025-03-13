import 'package:get/get.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';
import 'package:mbinu/ui/state_holders/auth/auth_controller.dart';

class OTPVerifyLoginController extends GetxController {
  bool _verifyLoginInProgress = false;
  static bool _isProfileComplete = false;

  static bool get isProfileComplete => _isProfileComplete;
  bool get verifyLoginInProgress => _verifyLoginInProgress;

  Future<bool> verifyLogin(String email, String otp) async {
    _verifyLoginInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.verifyOtp,
      {'email': email, 'otp': otp},
    );
    _verifyLoginInProgress = false;
    update();
    if (response.isSuccess && response.statusCode < 400) {
      await AuthController.setAccessToken(
        response.responseJson?["access_token"],
      );
      return true;
    } else {
      return false;
    }
  }

  void setProfile() {
    _isProfileComplete = true;
    update();
  }
}
