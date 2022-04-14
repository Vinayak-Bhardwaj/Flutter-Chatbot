import 'package:chatbot/Screens/Home/chat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHATBOT"),
      ),
      body: Center(
        child: Chat(),
      ),
    );
  }
}