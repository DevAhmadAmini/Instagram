// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';
import 'package:instagram_clone/Widgets/Feed%20Screen%20Widgets/post_tile_image.dart';
import 'package:intl/intl.dart';
import '../Widgets/Feed Screen Widgets/post_tile_footer.dart';
import '../Widgets/Feed Screen Widgets/post_tile_header.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "images/ic_instagram.svg",
          height: 30,
          width: 30,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.messenger_outline, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("posts").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No post",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var snap = snapshot.data!.docs[index].data();
                Timestamp time = snapshot.data!.docs[index]['datePublished'];
                String fdate = DateFormat('MMM dd, yyy').format(time.toDate());
                return Column(
                  children: [
                    PostTileHeader(
                      snap: snap,
                      onDelete: () async {
                        await FireStoreMethods().deletePost(
                          snapshot.data!.docs[index]['postId'],
                        );
                      },
                    ),
                    PostTileImage(snap: snap),
                    PostTileFooter(snap: snap, time: fdate),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
