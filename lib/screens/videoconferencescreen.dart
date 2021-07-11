import 'package:flutter/material.dart';
import 'package:myteams/helper/useful_functions.dart';
import 'package:myteams/videomeeting/createmeet.dart';
import 'package:myteams/videomeeting/joinmeeting.dart';

// page to show join meet and create meet  tabs
class VideoConferenceScreen extends StatefulWidget {
  @override
  VideoConferenceScreenState createState() => VideoConferenceScreenState();
}

class VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  //tab build
  buildTab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            name,
            style: mystyle(18, Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  //building the layout of the page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        title: Text(
          "MyTeams",
          style: mystyle(40, Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.1, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [buildTab("Join Meeting"), buildTab("Create Meeting")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [JoinMeetingScreen(), CreateMeetingScreen()],
      ),
    );
  }
}
