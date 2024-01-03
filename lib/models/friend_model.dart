import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final Uint8List? friendImage;

  final String? name;

  final String? mobile;

  final String? desc;

  const FriendModel({
    this.friendImage,
    this.name,
    this.mobile,
    this.desc,
  });

 
  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      name: map['friendName'] as String,
      mobile: map['friendNumber'] as String,
      desc: map['friendDex'] as String,

      // initialize other fields...
    );
  }
}
