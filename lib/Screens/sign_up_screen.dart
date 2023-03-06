// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_is_not_empty

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Screens/sign_in_screen.dart';
import '../Resources/auth.dart';
import '../Widgets/text_field_input.dart';
import '../utils/utils.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "signUp-screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? emailValidation(String? email) {
    if (email!.isNotEmpty && !EmailValidator.validate(email)) {
      return "the email is badly formatted";
    } else {
      return null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool isSignUpLoading = false;
  void createUser() async {
    final isValidate = _formKey.currentState!.validate();
    if (isValidate) {
      setState(() {
        isSignUpLoading = true;
      });
      String res = await AuthMethods().signUpMethod(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: image,
        context: context,
      );
      setState(() {
        isSignUpLoading = false;
      });
      if (res == "success") {
        showSnackBar(
          context: context,
          content: "User has been Created",
        );
      } else {
        showSnackBar(
          context: context,
          content: res,
        );
      }
    } else {
      showSnackBar(
          context: context,
          content: "Some Fields are still empty or not initionilzed correctly");
    }
  }

  navigateToSignInScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignInScreen();
    }));
  }

  String? passwordValidation(String? password) {
    if (password!.isEmpty || password.trim().length < 8) {
      return "Password must be at least 8 characters";
    } else {
      return null;
    }
  }

  String? usernameValidator(String? username) {
    if (username!.isEmpty) {
      return "username is still empty";
    } else {
      return null;
    }
  }

  Uint8List? image;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "images/ic_instagram.svg",
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 40,
                                backgroundImage: MemoryImage(image!),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 40,
                              ),
                        Positioned(
                          left: 44,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () async {
                              Uint8List im =
                                  await pickImage(source: ImageSource.gallery);
                              setState(() {
                                image = im;
                              });
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 46),
                  TextFieldInput(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: emailValidation,
                    hintText: "Insert Your Email",
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) => passwordValidation(password),
                    hintText: "Insert Your Password",
                    isPassword: true,
                    textInputType: TextInputType.text,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    validator: (username) =>
                        usernameValidator(AutofillHints.newUsername),
                    hintText: "Insert Your username",
                    textInputType: TextInputType.text,
                    controller: usernameController,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    hintText: "Insert Your bio",
                    textInputType: TextInputType.text,
                    controller: bioController,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      //TODO make a model to sign up

                      onPressed: createUser,
                      // perform login method
                      child: isSignUpLoading == true
                          ? const SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do have an account? '),
                      GestureDetector(
                        onTap: navigateToSignInScreen,
                        // going to sign up screen
                        child: const Text(
                          ' Sign In ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
