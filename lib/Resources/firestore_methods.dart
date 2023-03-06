import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Models/post.dart';
import 'package:instagram_clone/Models/user.dart' as model;
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? postUid;
  addUserDataToFirestore({
    required UserCredential cred,
    required String email,
    required String photoUrl,
    required String password,
    required String username,
    required String bio,
  }) async {
    model.User user = model.User(
      password: password,
      username: username,
      id: cred.user!.uid,
      bio: bio,
      photoUrl: photoUrl,
      email: email,
      followers: [],
      following: [],
    );
    await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
  }

  Future<String> addPostDataToFirestore({
    required DateTime date,
    required String description,
    required String? username,
    required String? photoUrl,
    required String? postPhotoUrl,
    required String? userId,
    required String postId,
  }) async {
    postUid = postId;
    String res = "";
    Post post = Post(
      postId: postUid,
      likes: [],
      datePublished: date,
      description: description,
      photoUrl: photoUrl!,
      postPhotoUrl: postPhotoUrl,
      userId: userId!,
      username: username!,
    );

    await _firestore.collection("posts").doc(postUid).set(post.toMap());

    return res;
  }

// updating user data for state management
  Future<model.User> getUserDataProvider() async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

    return model.User(
      username: (snapshot.data() as Map<String, dynamic>)['username'],
      id: (snapshot.data() as Map<String, dynamic>)['id'],
      bio: (snapshot.data() as Map<String, dynamic>)['bio'],
      photoUrl: (snapshot.data() as Map<String, dynamic>)['photoUrl'],
      email: (snapshot.data() as Map<String, dynamic>)['email'],
      followers: (snapshot.data() as Map<String, dynamic>)['followers'],
      following: (snapshot.data() as Map<String, dynamic>)['following'],
      password: (snapshot.data() as Map<String, dynamic>)['password'],
    );
  }

  String? getPostId() {
    return postUid;
  }

  Future<void> getLikes({
    required List likes,
    required String userId,
    required String postId,
  }) async {
    try {
      if (likes.contains(userId)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([userId]),
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([userId]),
        });
      }
    } catch (error) {}
  }

  Future<void> getComments({
    required String? username,
    required String? userId,
    required String? postId,
    required String photoUrl,
    required String commentText,
    // required Timestamp? datePublished,
  }) async {
    String commentId = const Uuid().v1();

    await _firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .set({
      "username": username,
      "userId": userId,
      "postId": postId,
      "photoUrl": photoUrl,
      "commentText": commentText,
      // "datePublished": datePublished,
    });

    QuerySnapshot snapshotLen = await _firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .get();
    int commentNumber = snapshotLen.docs.length;
    String commentNum = const Uuid().v1();

    await _firestore
        .collection("posts")
        .doc(postId)
        .collection("commentNumbers")
        .doc(commentNum)
        .set({
      "commentNumbers": commentNumber,
    });
  }

  Future<String> handleFollowersAndFollowing({
    required List? followers,
    required String myId,
    required String? youId,
  }) async {
    String res = '';
    if (followers!.contains(myId)) {
      await _firestore.collection("users").doc(youId).update({
        "followers": FieldValue.arrayRemove([_auth.currentUser!.uid]),
      });

      await _firestore.collection("users").doc(myId).update({
        "following": FieldValue.arrayRemove([youId]),
      });
      res = 'follow';
    } else {
      await _firestore.collection("users").doc(youId).update({
        "followers": FieldValue.arrayUnion([myId]),
      });
      await _firestore.collection("users").doc(myId).update({
        "following": FieldValue.arrayUnion([youId]),
      });
      res = 'unfollow';
    }
    return res;
  }

  Future deletePost(String? postId) async {
    await _firestore.collection("posts").doc(postId).delete();
  }

  Future<model.User> getDataProvider() async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    return model.User(
      bio: snapshot['bio'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      id: snapshot['id'],
      password: snapshot['password'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
    );
  }
}
