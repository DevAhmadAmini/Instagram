import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Screens/profile_screen.dart';

class PostTileHeader extends StatelessWidget {
  final snap;
 final VoidCallback onDelete;
  const PostTileHeader({super.key, required this.snap,required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
            //   Navigator.push(
            // context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(snap['photoUrl']),
                ),
                const SizedBox(width: 9.0),
                Text(
                  snap['username'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
