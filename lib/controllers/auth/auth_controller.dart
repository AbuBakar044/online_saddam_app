import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future<void> loginUser() async {}

  Future<void> registerUser(String email, String password) async {
    firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
