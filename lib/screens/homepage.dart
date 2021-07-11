import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myteams/helper/useful_functions.dart';
import 'package:myteams/screens/profilescreen.dart';
import 'package:myteams/screens/videoconferencescreen.dart';
import 'chat_home_page.dart';

// home page
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [VideoConferenceScreen(), ChatHomePage(), ProfileScreen()];
  @override
  // building basic layout to shows the bottom navigation bar
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink,
        selectedLabelStyle: mystyle(18, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(18, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Meetings"),
            icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            title: Text("Chat"),
            icon: Icon(Icons.chat, size: 32),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.person, size: 32),
          )
        ],
      ),
      body: pageoptions[page],
    );
  }
}
