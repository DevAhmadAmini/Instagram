import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadUserAvatarToStorage({
    required picId,
    required Uint8List? file,
  }) async {
    Reference reference = _storage.ref().child("profilePics").child(picId);
    UploadTask uploadTask = reference.putData(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadPostImageToStorage({
    required Uint8List? postImage,
    required String? uid,
    required String postId,
  }) async {
    Reference reference =
        _storage.ref().child("postImages").child(uid!).child(postId);
    UploadTask uploadTask = reference.putData(postImage!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
