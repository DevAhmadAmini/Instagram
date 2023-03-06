import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';
import 'package:instagram_clone/user_provider.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:uuid/uuid.dart';
import '../Models/user.dart';
import '../Widgets/comment_tile.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.snap['postId'])
        .collection("comments")
        .snapshots();
  }

  DateTime date = DateTime.now();
  var commentId = const Uuid().v1();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 6),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                user.photoUrl,
              ),
              backgroundColor: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 9),
              child: SizedBox(
                width: 223,
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What is in your mind?",
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await FireStoreMethods().getComments(
                  username: user.username,
                  userId: user.id,
                  postId: widget.snap['postId'],
                  photoUrl: user.photoUrl,
                  commentText: _commentController.text,
                );
              },
              child: const Text(
                "post",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getComments(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final snap = snapshot.data!.docs[index].data();
              return CommentTile(snap: snap);
            },
          );
        },
      ),
    );
  }
}
