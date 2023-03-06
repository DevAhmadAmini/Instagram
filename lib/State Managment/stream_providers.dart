import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamProviders {
  // Getting QuerySnapshots for users collection
  static final userStreamProvider = StreamProvider.autoDispose<QuerySnapshot>(
    (ref) => FirebaseFirestore.instance.collection("users").snapshots(),
  );
  // Getting DocumentSnapshots for users collection

  static final userProfileStreamProvider =
      StreamProvider.autoDispose((ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .snapshots();
  });

    // Getting QuerySnapshots for posts collection

  static final postStreamProvider = StreamProvider.autoDispose<QuerySnapshot>(
    (ref) => FirebaseFirestore.instance.collection("posts").snapshots(),
  );
}
