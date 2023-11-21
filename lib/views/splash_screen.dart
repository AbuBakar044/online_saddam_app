import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saddam_app/controllers/splash_controller.dart';
import 'package:saddam_app/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  Widget build(BuildContext context) {
    Get.put<SplashController>(SplashController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/3.png',
              height: 200.0,
              width: 200.0,
            ),
            const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
