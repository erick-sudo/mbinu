import 'package:get/get.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;
  String _message = '';

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  String get message => _message;

  Future<bool> verifyEmail(String email) async {
    _emailVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.userLogin(email),
    );
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess && response.statusCode == 200) {
      _message = response.responseJson?['data'] ?? "";
      return true;
    }
    return false;
  }
}
