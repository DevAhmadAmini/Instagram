import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/firestore_methods.dart';
import 'package:instagram_clone/Resources/storage_methods.dart';
import 'package:instagram_clone/Widgets/error_dialog.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpMethod({
    required String email,
    required String password,
    required String username,
    String bio = '',
    Uint8List? file,
    required BuildContext context,
  }) async {
    String res = "";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Upload Image to Storage

        String photoUrl = await StorageMethods().uploadUserAvatarToStorage(
          picId: cred.user!.uid,
          // ignore: todo
          //TODO come up with an image if file is null
          file: file,
        );

        // Add Data to Firestore

        await FireStoreMethods().addUserDataToFirestore(
          cred: cred,
          email: email,
          password: password,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
        );
      }

      res = "success";
      //TODO try using FirebaseAuthException
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "The Email Address you entered is not valid";
      } else if (error.code == "weak-password") {
        res = "Password must be at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorDialog(
            errorText: "Something went wrong Please try again",
          );
        },
      );
    }
    return res;
  }

  Future<String> signInMethod({
    required String email,
    required String password,
  }) async {
    String res = '';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "The email adrress is not valid";
      } else if (error.code == "user-not-found") {
        res = "User not found";
      }
    } catch (err) {
      //TODO make a suitable error
      res = err.toString();
    }
    return res;
  }
}
