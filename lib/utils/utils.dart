import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage({required ImageSource source}) async {
  XFile? xfile = await ImagePicker().pickImage(
    source: source,
    imageQuality: 90,
  );

  if (xfile != null) {
    return await xfile.readAsBytes();
  } else {}
}

showSnackBar({
  required BuildContext context,
  required String content,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

navigatePop(context) {
  Navigator.pop(context);
}
