// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_clone/test.dart';
// import 'package:intl/intl.dart';

// class PostProvider extends ConsumerWidget {
//   const PostProvider({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(Test.postStreamProvider).when(
//       data: (data) {
//         int len = data.docs.length;
//         return Scaffold(
//           body: ListView.builder(
//             itemCount: len,
//             itemBuilder: (context, index) {
//               String username = data.docs[index]['username'];
//               Timestamp datePublished = data.docs[index]['datePublished'];
//               String date = DateFormat("MMM dd, yyyy").format(
//                 datePublished.toDate(),
//               );
//               final usernameWidget = Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(username),
//                   Text(date),
//                 ],
//               );
//               return usernameWidget;
//             },
//           ),
//         );
//       },
//       error: (error, stackTrace) {
//         return Scaffold(body: Text(error.toString()));
//       },
//       loading: () {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
