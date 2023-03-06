import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Responsive/responsive_layout.dart';
import 'package:instagram_clone/Responsive/web_layout.dart';
import 'package:instagram_clone/Screens/sign_in_screen.dart';
import 'package:instagram_clone/user_provider.dart';
import 'package:instagram_clone/utils/color.dart';
import 'Responsive/mobile_layout.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileLayout: MobileLayout(),
                  webLayout: WebLayout(),
                );
              } else {
                return const SignInScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
