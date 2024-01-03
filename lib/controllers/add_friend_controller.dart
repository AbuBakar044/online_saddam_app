import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final nameCtrl = TextEditingController();
  final nmbrCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  Future<void> addFriends() async {
    Map<String, dynamic> friends = {
      'friendName': nameCtrl.text,
      'friendNumber': nmbrCtrl.text,
      'friendDex': descCtrl.text,
    };
    firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      'friends': FieldValue.arrayUnion([friends])
    }).then((value) {
      Get.snackbar('Saddam App', 'Friend Saved1');
         nameCtrl.clear();
        nmbrCtrl.clear();
        descCtrl.clear();
    });
  }
}
