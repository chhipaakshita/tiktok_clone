import 'package:flutter/material.dart';
import 'package:tiktok_clone/home/following/following_video_screen.dart';
import 'package:tiktok_clone/home/for_you/for_you_video_screen.dart';
import 'package:tiktok_clone/home/profile/profile_screen.dart';
import 'package:tiktok_clone/home/search/search_screen.dart';
import 'package:tiktok_clone/home/upload_video/upload_custom_icon.dart';
import 'package:tiktok_clone/home/upload_video/upload_video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List screensList= [
      ForYouVideoScreen(),
      SearchScreen(),
      UploadVideoScreen(),
      FollowingVideoScreen(),
      ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // child: Text("Dashboard Screen"),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 30,),
                label: "home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,size: 30,),
                label: "Discover"
            ),
            BottomNavigationBarItem(
                icon: UploadCustomIcon(),
                label: ""
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.inbox_sharp,size: 30,),
                label: "Following"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,size: 30,),
                label: "Me"
            ),

          ],
        onTap: (index){
            setState(() {
              screenIndex = index;
            });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
      ),
      body: screensList[screenIndex],
    );
  }
}
