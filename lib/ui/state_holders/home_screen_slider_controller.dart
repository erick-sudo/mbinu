import 'package:get/get.dart';
import 'package:mbinu/data/models/home_screen_slider_model.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/data/services/network_caller.dart';
import 'package:mbinu/data/utils/url_links.dart';

class HomeScreenSliderController extends GetxController {
  bool _homeScreenSliderInProgress = false;
  HomeScreenSliderModel _homeScreenSliderModel = HomeScreenSliderModel();
  String _message = "";

  bool get homeScreenSliderInProgress => _homeScreenSliderInProgress;
  HomeScreenSliderModel get homeScreenSliderModel => _homeScreenSliderModel;
  String get message => _message;

  Future<bool> getHomeScreenSlider() async {
    _homeScreenSliderInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.homeScreenSlider,
    );
    _homeScreenSliderInProgress = false;
    if (response.isSuccess && response.statusCode == 200) {
      _homeScreenSliderModel = HomeScreenSliderModel.fromJson(
        response.responseJson ?? {},
      );
      update();
      return true;
    } else {
      _message = "Slider fetch failed!";
      update();
      return false;
    }
  }
}
