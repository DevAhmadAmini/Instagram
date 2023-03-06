import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/user_provider.dart';
import '../Screens/feed_screen.dart';
import '../Screens/profile_screen.dart';
import '../Screens/search_screen.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshData();
  }

  int? _page;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int page) {
          _page = page;
          setState(() {});
        },
        controller: pageController,
        children: [
          const FeedScreen(),
          const SearchScreen(),
          const AddPostScreen(),
          Center(
            child: GestureDetector(
              onTap: () async {
                await auth.signOut();
              
              },
              child: const Text("log out"),
            ),
          ),
          ProfileScreen(id: auth.currentUser!.uid),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int page) {
          pageController!.jumpToPage(page);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_to_photos,
              color: Colors.white,
            ),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_add,
              color: Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
