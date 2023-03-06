import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommentTile extends StatelessWidget {
  final snap;

  const CommentTile({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 18.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: CachedNetworkImageProvider(
              snap["photoUrl"],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 50, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.clip,
                    maxLines: 10,
                    text: TextSpan(
                      text: snap['username'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "  ${snap['commentText']}",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
