import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';

class UserTile extends StatelessWidget {
  final String photoUrl;
  final String username;
  final String id;
  const UserTile({
    super.key,
    required this.username,
    required this.photoUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      id: id,
                    )));
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(photoUrl),
          ),
          const SizedBox(width: 16),
          Text(
            username,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
