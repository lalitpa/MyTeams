import 'package:flutter/material.dart';
import 'package:myteams/screens/register_page.dart';
import 'package:myteams/screens/signin_page.dart';

// to show the sign in screen or sign up screen according to the current status
class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool _showSignIn = true;
  // switching between the screens of sign in and sign up screens
  void _toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignInPage(toggleView: _toggleView);
    } else {
      return RegisterPage(toggleView: _toggleView);
    }
  }
}
