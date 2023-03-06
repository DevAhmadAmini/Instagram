import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';
import '../../Screens/comments_screen.dart';

class PostTileFooter extends StatefulWidget {
  final snap;
  final String? time;
  const PostTileFooter({super.key, required this.snap, required this.time});

  @override
  State<PostTileFooter> createState() => _PostTileFooterState();
}

class _PostTileFooterState extends State<PostTileFooter> {
  late int? commentNumber;
  // String? res;
  // bool isLike = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () async {
                    await FireStoreMethods().getLikes(
                      likes: widget.snap["likes"],
                      userId: widget.snap["userId"],
                      postId: widget.snap["postId"],
                    );
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.favorite,
                    // color: res == "liked" ? Colors.red : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsScreen(snap: widget.snap,)));
                  },
                  icon: const Icon(
                    Icons.chat_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_outline,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, bottom: 7.0),
          child: Text(
            "${widget.snap["likes"].length} likes",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, bottom: 3.0, right: 70),
          child: Text(
            widget.snap['description'],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(widget.snap["postId"])
              .collection("commentNumbers")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              commentNumber = 0;
              return const Text('');
            }
            snapshot.data!.docs.forEach((doc) {
              commentNumber = doc["commentNumbers"];
            });
            return Padding(
              padding: const EdgeInsets.only(left: 13.0, bottom: 5.0),
              child: Text(
                "view all $commentNumber comments",
                style: const TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Text(
            widget.time!,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
