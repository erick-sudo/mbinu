import 'package:get/get.dart';

class MainScreenController extends GetxController {
  int currentSelectedIndex = 0;

  void onChanged(int index) {
    currentSelectedIndex = index;
    update();
  }

  void backToHomeScreen() {
    onChanged(0);
  }
}
