// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Resources/auth.dart';
import 'package:instagram_clone/Screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import '../Widgets/text_field_input.dart';

class SignInScreen extends StatefulWidget {
  static String id = "signIn-screen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  void loginUser() async {
    setState(() {
      isSignInLoading = true;
    });
    String res = await AuthMethods().signInMethod(
      email: emailController.text,
      password: passwordController.text,
    );
    setState(() {
      isSignInLoading = false;
    });
    if (res == "success") {
      showSnackBar(
        context: context,
        content: "Successfully Signed In",
      );
      setState(() {});
    } else {
      showSnackBar(
        context: context,
        content: res,
      );
    }
  }

  navigateToSignUpScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  bool isSignInLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
              const SizedBox(height: 46),
              TextFieldInput(
                hintText: "Insert Your Email",
                isPassword: false,
                textInputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                hintText: "Insert Your Password",
                isPassword: true,
                textInputType: TextInputType.text,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  // perform login method
                  onPressed: loginUser,
                  child: isSignInLoading == true
                      ? const SizedBox(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "login",
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
                  const Text('Do not have an account? '),
                  GestureDetector(
                    onTap: navigateToSignUpScreen,
                    // going to sign up screen
                    child: const Text(
                      ' Sign up ',
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
    );
  }
}
