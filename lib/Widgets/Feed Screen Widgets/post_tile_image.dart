import 'package:flutter/material.dart';

class PostTileImage extends StatelessWidget {
  final snap;
 const  PostTileImage({super.key, required this.snap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 350,
      child: Image.network(
        snap["postPhotoUrl"],
        fit: BoxFit.cover,
      ),
    );
  }
}
