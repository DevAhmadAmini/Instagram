// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Models/user.dart' as model;
import 'package:instagram_clone/Resources/storage_methods.dart';
import 'package:instagram_clone/Responsive/mobile_layout.dart';
import 'package:instagram_clone/Widgets/choose_image_dialog.dart';
import 'package:instagram_clone/user_provider.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:uuid/uuid.dart';
import '../Resources/firestore_methods.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static String id = "add-post-screen";
  final Uint8List? file;

  const AddPostScreen({super.key, this.file});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var randomPostId = const Uuid().v1();
  final DateTime currentTime = DateTime.now();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return widget.file == null
        ? Center(
            child: IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ChooseImageDialog();
                  },
                );
              },
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post to"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextButton(
                    onPressed: () async {
                      try {
                        String postImage =
                            await StorageMethods().uploadPostImageToStorage(
                          postId: randomPostId,
                          uid: user.id,
                          postImage: widget.file,
                        );

                        await FireStoreMethods().addPostDataToFirestore(
                          postId: randomPostId,
                          date: currentTime,
                          description: descriptionController.text,
                          username: user.username,
                          photoUrl: user.photoUrl,
                          postPhotoUrl: postImage,
                          userId: user.id,
                        );
                        descriptionController.clear();
                        // ignore: todo
                        //TODO do it
                        // setState(() {
                        //   widget.file = null;
                        // });
                        showSnackBar(
                          content: "Posted Successfully",
                          context: context,
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MobileLayout();
                        }));
                      } catch (error) {
                        showSnackBar(
                          content: "$error",
                          context: context,
                        );
                      }
                    },
                    child: const Text(
                      "post",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                // isPosting
                //     ? const Padding(
                //         padding: EdgeInsets.symmetric(vertical: 6),
                //         child: LinearProgressIndicator(),
                //       )
                //     : const Text(""),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                        radius: 20,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "write a caption...",
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      SizedBox(
                        width: 55,
                        height: 50,
                        child: AspectRatio(
                          aspectRatio: 356 / 345,
                          child: Image(
                            image: MemoryImage(widget.file!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
