import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';
import 'package:instagram_clone/utils/color.dart';
import '../Widgets/Profile Widgets/reuseable_button.dart';
import '../Widgets/Profile Widgets/reuseable_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  final String? id;
  const ProfileScreen({super.key, required this.id});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollow = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getUserData();
    getPostLen();
  }

  int? postLen;
  var userData;
  Stream<DocumentSnapshot> getUserData() {
    return _firestore.collection("users").doc(widget.id).snapshots();
  }

  Future<void> getPostLen() async {
    final data = await _firestore
        .collection("posts")
        .where("userId", isEqualTo: widget.id)
        .get();
    postLen = data.docs.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        userData = snapshot.data!.data();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            title: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                userData!['username'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                          userData!['photoUrl'],
                        ),
                      ),
                      ReuseableCard(
                        text: "Posts",
                        num: postLen ?? 0,
                      ),
                      ReuseableCard(
                        text: "Followers",
                        num: userData!['followers'].length,
                      ),
                      ReuseableCard(
                        text: "Following",
                        num: userData!["following"].length,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _auth.currentUser!.uid == widget.id
                          ? ReuseableButton(
                              buttonText: "Edit Profile",
                              onPressed: () {},
                            )
                          : ReuseableButton(
                              buttonText: "Follow",
                              onPressed: () async {
                                String res = await FireStoreMethods()
                                    .handleFollowersAndFollowing(
                                  followers: userData!['followers'],
                                  myId: _auth.currentUser!.uid,
                                  youId: widget.id,
                                );
                              },
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0, top: 25.0),
                    child: Text(
                      userData!['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0, top: 3),
                    child: Text(userData!['bio']),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
