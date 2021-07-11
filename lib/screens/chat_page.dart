import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myteams/helper/message_tile.dart';
import 'package:myteams/services/database_service.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

// chat page class
class ChatPage extends StatefulWidget {
// required fields declaration
  final String groupId;
  final String userName;
  final String groupName;

  ChatPage({this.groupId, this.userName, this.groupName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // stream chats
  Stream<QuerySnapshot> _chats;
  TextEditingController messageEditingController = new TextEditingController();
  ScrollController scrolling = ScrollController();
  _Scrolltobottom() {
    scrolling.jumpTo(scrolling.position.maxScrollExtent);
  }

// to show chat messages screen
  Widget _chatMessages() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _Scrolltobottom());

    return StreamBuilder(
      stream: _chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                controller: scrolling,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  _Scrolltobottom();
                  //show chat messages
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sender: snapshot.data.documents[index].data["sender"],
                    sentByMe: widget.userName ==
                        snapshot.data.documents[index].data["sender"],
                  );
                })
            : Container();
      },
    );
  }

// fetch the message and save to database
  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
        _Scrolltobottom();
      });
      scrolling.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseService().getChats(widget.groupId).then((val) {
      // print(val);
      setState(() {
        _chats = val;
      });
    });
  }

  //join meet button
  // can join the group meet
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
        ..room = widget.groupName // Required, spaces will be trimmed
        ..userDisplayName = widget.userName
        ..audioMuted = true
        ..videoMuted = true
        ..featureFlag = featureFlag;
      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  //building layout
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName,
            style: TextStyle(fontSize: 30, color: Colors.white)),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              icon: Icon(Icons.video_call, color: Colors.white, size: 35.0),
              onPressed: () {
                joinMeet();
              })
        ],
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
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 70),
              child: _chatMessages(),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                color: Colors.grey[700],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Send a message ...",
                            hintStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
