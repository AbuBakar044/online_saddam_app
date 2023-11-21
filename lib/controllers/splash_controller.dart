import 'package:get/get.dart';
import 'package:saddam_app/views/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      Get.off(() => HomeScreen());
    });
    super.onInit();
  }
}
