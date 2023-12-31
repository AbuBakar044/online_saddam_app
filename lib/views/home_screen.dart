import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:saddam_app/views/add_friends_screen.dart';
import 'package:saddam_app/models/friend_model.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FriendModel> friendsList = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    //getAllFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('My Friends'),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFriendsScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),

      body: Container(
          height: MediaQuery.sizeOf(context).height,
          child: StreamBuilder(
              stream: firebaseFirestore
                  .collection('users')
                  .doc(firebaseAuth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var friends = snapshot.data!['friends'] as List;
                  friendsList =
                      friends.map((e) => FriendModel.fromMap(e)).toList();
                  return ListView.builder(
                    itemCount: friendsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.amber,
                          onLongPress: () {
                            showDeleteDialog(index);
                          },
                          // leading: CircleAvatar(
                          //   radius: 30.0,
                          //   backgroundImage: MemoryImage(
                          //     friendsList[index].friendImage!,
                          //   ),
                          // ),
                          title: Row(
                            children: [
                              Expanded(
                                  //flex: 2,
                                  child: Text(
                                friendsList[index].name!,
                                textAlign: TextAlign.left,
                                //overflow: TextOverflow.ellipsis,
                              )),
                              //Spacer(),
                              Expanded(
                                  //flex: 1,
                                  child: Text(
                                friendsList[index].mobile!,
                                textAlign: TextAlign.right,
                              )),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(child: Text(friendsList[index].desc!)),
                              IconButton(
                                onPressed: () {
                                  showCallDialog(index);
                                },
                                icon: const Icon(
                                  Icons.call,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }

  // Future<void> getAllFriends() async {
  //   print('...................${friendsList.length}');
  // }

  Future<void> showDeleteDialog(int index) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Friend'),
            content: Text('Are you sure to delete your friend?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  deleteFriend(index).then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Friend Deleted Successfully',
                        ),
                      ),
                    );
                  });
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showCallDialog(int index) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Call Friend'),
            content: const Text('Choose a method to call your friend'),
            actions: [
              TextButton(
                onPressed: () {
                  callMyFriend(friendsList[index].mobile!);
                },
                child: const Text(
                  'Phone',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  whatsAppMyFriend(friendsList[index].mobile!);
                },
                child: const Text(
                  'WhatsApp',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> deleteFriend(int index) async {
    friendsList.removeAt(index);
    //await friendBox!.deleteAt(index);
  }

  Future<void> callMyFriend(String number) async {
    await launch('tel:$number');
  }

  Future<void> whatsAppMyFriend(String number) async {
    final whatsAppNumber = number.replaceFirst(RegExp(r'0'), '+92');
    final link =
        WhatsAppUnilink(phoneNumber: whatsAppNumber, text: 'Hy my friend');
    await launch(link.toString());
  }
}
