import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saddam_app/views/home_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  final passCtrl = TextEditingController();

  Future<void> loginUser() async {}

  Future<void> registerUser(String name, String email, String password) async {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          saveUserData(name, password, email);
        });
  }

  Future<void> saveUserData(String name, String pass, String email) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Map<String, dynamic> userData = {
      'name': name,
      'email': emailCtrl.text,
      'pass': passCtrl.text,
    };

    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(userData)
        .then((value) {
      Get.snackbar('Saddam App', 'User Saved Successfully!');
      Get.offAll(() => const HomeScreen());
    });
  }
}
