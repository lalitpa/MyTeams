import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:myteams/helper/helper_functions.dart';
import 'package:myteams/helper/useful_functions.dart';
import 'package:myteams/services/auth_service.dart';

import 'authenticate_page.dart';

// profile page screen
class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  // get the user and user info
  final AuthService _auth = AuthService();
  FirebaseUser _user;
  TextEditingController usernamecontroller = TextEditingController();
  String username = "";
  bool dataisthere = false;
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
    getuserdata();
    getusername();
  }

  getuserdata() async {
    setState(() {
      dataisthere = true;
    });
  }

// edit username
  editprofile() async {
    if (usernamecontroller.text != '') {
      setState(() {
        username = usernamecontroller.text;
        String fullName = username;
        HelperFunctions.saveUserNameSharedPreference(fullName);
      });
      Navigator.pop(context);
    }
  }

// dialog box opening to change the username
  openeditprofiledialogue() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      style: mystyle(18, Colors.black),
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        labelText: "Update Username",
                        labelStyle: mystyle(16, Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => editprofile(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: GradientColors.blue,
                      )),
                      child: Center(
                        child: Text(
                          "Update Username",
                          style: mystyle(17, Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  //building layout widget
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataisthere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 67,
                    top: MediaQuery.of(context).size.height / 3.1,
                  ),
                  child: InkWell(
                    child: CircleAvatar(
                      radius: 67,
                      backgroundColor: Colors.blueGrey,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset("images/user.png"),
                        radius: 64,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        username,
                        style: mystyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => openeditprofiledialogue(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
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
                              "Edit Profile",
                              style: mystyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          await _auth.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => AuthenticatePage()),
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: GradientColors.red,
                          )),
                          child: Center(
                            child: Text(
                              "Sign Out",
                              style: mystyle(17, Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
