// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_clone/test.dart';

// class UserStreamProvider extends ConsumerWidget {
//   const UserStreamProvider({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(Test.userStreamProvider).when(
//       data: (data) {
//         int len = data.docs.length;
//         return Scaffold(
//           body: ListView.builder(
//             itemCount: len,
//             itemBuilder: (context, index) {
//               String email = data.docs[index]['email'];
//               final usernameWidget = Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(email),
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
