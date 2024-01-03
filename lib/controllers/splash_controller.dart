import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saddam_app/views/auth/login.dart';
import 'package:saddam_app/views/home_screen.dart';

class SplashController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void onInit() {
    getRoutes();
    
    super.onInit();
  }

  Future<void> getRoutes() async{
    if (firebaseAuth.currentUser != null) {
      Future.delayed(
          const Duration(
            seconds: 5,
          ), () {
        Get.off(() => HomeScreen());
      });
    }else{
      Future.delayed(
          const Duration(
            seconds: 5,
          ), () {
        Get.off(() => LoginPage());
      });
    }
  }
}
