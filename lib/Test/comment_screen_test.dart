// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/Resources/firestore_methods.dart';
// import 'package:instagram_clone/State%20Managment/stream_providers.dart';
// import 'package:instagram_clone/utils/color.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
// import '../Widgets/comment_tile.dart';

// class CommentsScreen extends StatefulWidget {
//   const CommentsScreen({
//     super.key,
//   });

//   @override
//   State<CommentsScreen> createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
//   String username = '';
//   Timestamp? datePublished;
//   String userId = '';
//   String? postId;
//   String photoUrl = '';
//   DateTime date = DateTime.now();
//   var commentId = const Uuid().v1();
//   final TextEditingController _commentController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
//         child: Consumer(
//           builder: (context, ref, child) {
//             return ref.watch(StreamProviders.postStreamProvider).when(
//               data: (data) {
//                 data.docs.map((doc) {
//                   username = doc['username'];
//                   datePublished = doc['datePublished'];
//                   userId = doc['id'];
//                   postId = doc['postId'];
//                   photoUrl = doc['photoUrl'];
//                 });
//                 return Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: CachedNetworkImageProvider(
//                         "https://th.bing.com/th/id/OIP.ewQ01WGeLzMa22dxsZly7gHaFX?pid=ImgDet&rs=1",
//                       ),
//                       backgroundColor: Colors.blue,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12, right: 9),
//                       child: SizedBox(
//                         width: 223,
//                         child: TextField(
//                           controller: _commentController,
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "What is in your mind?",
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         await FireStoreMethods().getComments(
//                           username: 'Ahmad',
//                           userId: userId,
//                           postId: "02ae9d50-b4bd-11ed-98c3-3dbb2251f24c",
//                           photoUrl: "https://th.bing.com/th/id/OIP.ewQ01WGeLzMa22dxsZly7gHaFX?pid=ImgDet&rs=1",
//                           commentText: _commentController.text,
//                           datePublished: datePublished,
//                         );
//                       },
//                       child: const Text(
//                         "post",
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               error: (error, strackTrace) {
//                 return Text(error.toString());
//               },
//               loading: () {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         title: const Text("Comments"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection("posts")
//             .doc(postId)
//             .collection("comments")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: Text("No Comments"),
//             );
//           } else if (snapshot.hasError) {
//             return const Text("something went wrong please try again");
//           }
//           snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               Timestamp date = snapshot.data!.docs[index]['datePublished'];
//               String currentDate =
//                   DateFormat("MMM dd, yyyy").format(date.toDate());
//               final snap = snapshot.data!.docs[index].data();
//               return CommentTile(
//                 snap: snap,
//                 date: currentDate,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
