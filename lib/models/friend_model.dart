import 'dart:typed_data';

class FriendModel {

  final Uint8List? friendImage;


  final String? name;


  final String? mobile;


  final String? desc;

  const FriendModel(
    this.friendImage,
    this.name,
    this.mobile,
    this.desc,
  );
}
