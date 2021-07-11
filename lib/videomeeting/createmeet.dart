import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:myteams/helper/useful_functions.dart';
import 'package:uuid/uuid.dart';

// create meeting
class CreateMeetingScreen extends StatefulWidget {
  @override
  CreateMeetingScreenState createState() => CreateMeetingScreenState();
}

class CreateMeetingScreenState extends State<CreateMeetingScreen> {
  String code = "";
  // to create the code of the meeting
  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  //building the page layout
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Create a code and share it with participants",
                style: mystyle(20),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code: ",
                style: mystyle(30),
              ),
              Text(
                code,
                style: mystyle(30, Colors.purple, FontWeight.w700),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [0.1, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Center(
                child: Text(
                  "Create Code",
                  style: mystyle(20, Colors.white, FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
