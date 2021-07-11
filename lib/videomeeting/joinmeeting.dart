import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myteams/helper/helper_functions.dart';
import 'package:myteams/services/auth_service.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:myteams/helper/useful_functions.dart';

// join meeting page
class JoinMeetingScreen extends StatefulWidget {
  @override
  JoinMeetingScreenState createState() => JoinMeetingScreenState();
}

class JoinMeetingScreenState extends State<JoinMeetingScreen> {
  // data and fields declaration
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  final AuthService _auth = AuthService();
  FirebaseUser _user;

  bool isCamOff = true;
  bool isMicOff = true;
  String username = '';
  //get user name
  getusername() async {
    _user = await FirebaseAuth.instance.currentUser();
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        username = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getusername();
  }

// to join the meet
  joinMeet() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
      featureFlag.inviteEnabled = false;
      featureFlag.conferenceTimerEnabled = false;
      featureFlag.calendarEnabled = false;
      featureFlag.liveStreamingEnabled = false;
      featureFlag.toolboxAlwaysVisible = false;
      featureFlag.videoShareButtonEnabled = false;

      var options = JitsiMeetingOptions()
        ..room = roomController.text // Required, spaces will be trimmed
        ..userDisplayName = username
        ..audioMuted = isMicOff
        ..videoMuted = isCamOff
        ..featureFlag = featureFlag;
      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  //building the layout of the join meet page
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 19),

              Text(
                "ROOM CODE",
                style: mystyle(30, Colors.pink),
              ), // Text

              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: roomController,
                  style: mystyle(20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Meeting Code",
                      labelStyle: mystyle(15))),

              SizedBox(
                height: 10,
              ),

              TextField(
                  controller: nameController,
                  style: mystyle(20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name (Leave if you want your username )",
                      labelStyle: mystyle(15))),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isCamOff,
                onChanged: (value) {
                  setState(() {
                    isCamOff = value;
                  });
                },
                title: Text(
                  "Camera Off",
                  style: mystyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isMicOff,
                onChanged: (value) {
                  setState(() {
                    isMicOff = value;
                  });
                },
                title: Text(
                  "Microphone Off",
                  style: mystyle(18, Colors.black),
                ),
              ),

              Divider(
                height: 50,
                thickness: 3.0,
              ),
              InkWell(
                onTap: () => joinMeet(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF915FB5),
                          const Color(0xFFCA436B)
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        stops: [0.1, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: mystyle(20, Colors.white, FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
