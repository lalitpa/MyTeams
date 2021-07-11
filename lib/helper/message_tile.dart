import 'package:flutter/material.dart';

//To show the messages in the chat
// if message send by the user himself then message will appear on the right side
// otherwise on left side of screen
class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  MessageTile({this.message, this.sender, this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.only(
          top: 4, bottom: 4, left: sentByMe ? 0 : 24, right: sentByMe ? 24 : 0),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sentByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
          color: sentByMe ? Colors.greenAccent : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sentByMe
                ? Text(
                    "",
                    style: TextStyle(fontSize: 0),
                  )
                : Text(sender.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: -0.5)),
            sentByMe
                ? SizedBox(
                    height: 0.0,
                  )
                : SizedBox(height: 7.0),
            Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
