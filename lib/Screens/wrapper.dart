import 'package:chatbot/Screens/Authenticate/SignIn/sign_in.dart';
import 'package:chatbot/Screens/Home/home.dart';
import 'package:chatbot/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return !auth.loggedIn ? SignIn() : Home();
  }
}