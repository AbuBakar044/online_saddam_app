import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:saddam_app/controllers/add_friend_controller.dart';
import 'package:saddam_app/models/friend_model.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  Uint8List? userImage;
  final _formKey = GlobalKey<FormState>();
  final addFrndCtrl = Get.put<AddFriendController>(AddFriendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            //Wrapped column with Form widget
            child: Form(
              //created _formKey
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showMySheet();
                    },
                    child: CircleAvatar(
                      //backgroundColor: Colors.black,
                      radius: 60.0,
                      backgroundImage: userImage == null
                          ? const AssetImage('assets/images/user.png')
                          : MemoryImage(userImage!) as ImageProvider,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: addFrndCtrl.nameCtrl,
                    //added validator

                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*please add name';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: addFrndCtrl.nmbrCtrl,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //added validator
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 11 ||
                          value.length > 11 ||
                          !value.startsWith('03')) {
                        return '*please add correct number';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: addFrndCtrl.descCtrl,
                    maxLines: 10,

                    //added validator
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*please add description';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //checked form current state
                      if (_formKey.currentState!.validate()) {
                        addFrndCtrl.addFriends();
                        //showed snackbar
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.green,
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showMySheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Pick your image',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          pickImageSource(ImageSource.camera).then((value) {
                            Navigator.pop(context);
                          });
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      IconButton(
                        onPressed: () {
                          pickImageSource(ImageSource.gallery).then((value) {
                            Navigator.pop(context);
                          });
                        },
                        icon: const Icon(
                          Icons.photo_album,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickImageSource(ImageSource imageSource) async {
    XFile? sourceImage = await ImagePicker().pickImage(source: imageSource);

    if (sourceImage == null) {
      return;
    } else {
      userImage = await sourceImage.readAsBytes();

      print(
          '........................... this is user Image ${userImage.toString()}');
      setState(() {});
    }
  }

  // Future<void> saveFriendData() async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   // Map<String, dynamic> userData = {
  //   //   'name';
  //   // };
  //   // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //   // firebaseFirestore
  //   //     .collection('users')
  //   //     .doc(firebaseAuth.currentUser!.uid)
  //   //     .set(data);
  //   var friendModel = FriendModel(
  //     userImage,
  //     nameCtrl.text,
  //     nmbrCtrl.text,
  //     descCtrl.text,
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text(
  //         'Friend Saved Successfully',
  //       ),
  //     ),
  //   );

  //   nameCtrl.clear();
  //   nmbrCtrl.clear();
  //   descCtrl.clear();
  //   userImage = null;

  //   setState(() {});
  // }
}
