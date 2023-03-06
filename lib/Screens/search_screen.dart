import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/color.dart';

import '../Widgets/Search Widgets/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? username;
  bool isShowSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          onFieldSubmitted: (value) {
            isShowSearch = true;
            setState(() {});
          },
          controller: _searchController,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "search for a user..."),
        ),
      ),
      body: isShowSearch
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where(
                    "username",
                    isGreaterThanOrEqualTo: _searchController.text,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No user found"),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final username = snapshot.data!.docs[index]['username'];
                    final photoUrl = snapshot.data!.docs[index]['photoUrl'];
                    final userId = snapshot.data!.docs[index]["id"];
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: UserTile(
                        username: username,
                        photoUrl: photoUrl,
                        id: userId,
                      ),
                    );
                  },
                );
              },
            )
          : Image.asset("images/search-image.jpg"),
    );
  }
}
