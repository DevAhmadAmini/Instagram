// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/utils/utils.dart';

class ChooseImageDialog extends StatefulWidget {
  const ChooseImageDialog({super.key});

  @override
  State<ChooseImageDialog> createState() => _ChooseImageDialogState();
}

class _ChooseImageDialogState extends State<ChooseImageDialog> {
  bool isUploading = false;
 Uint8List? image;

  takeImageFromCamera(BuildContext context) async {
    setState(() {
      isUploading = true;
    });
    // Navigator.pop(context);
    image = await pickImage(source: ImageSource.camera);
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPostScreen(file: image);
    }));
    setState(() {
      isUploading = false;
    });
  }

  selectImageFromGallery(BuildContext context) async {
    setState(() {
      isUploading = true;
    });
    // Navigator.pop(context);
    image = await pickImage(source: ImageSource.gallery);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPostScreen(file: image);
    }));
    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isUploading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              SimpleDialogOption(
                onPressed: () => takeImageFromCamera(context),
                child: const Text("Take image with Camera"),
              ),
              SimpleDialogOption(
                onPressed: () => selectImageFromGallery(context),
                child: const Text("choose image from gallery"),
              ),
              SimpleDialogOption(
                onPressed: () => navigatePop(context),
                child: const Text("Cancel"),
              ),
            ],
          );
  }
}
