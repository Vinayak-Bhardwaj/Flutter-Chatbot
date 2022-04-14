import 'package:chatbot/Screens/Authenticate/Register/register.dart';
import 'package:chatbot/Screens/Home/home.dart';
import 'package:chatbot/Screens/wrapper.dart';
import 'package:chatbot/Services/auth.dart';
import 'package:chatbot/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Screens/Authenticate/SignIn/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService _auth = AuthService();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => DatabaseService(uid: _auth.currentUser().uid)),
    ],
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/SignIn': (context) => auth.loggedIn ? Home() : SignIn(),
        '/Register': (context) => auth.loggedIn ? Home() : Register(),
        '/Home': (context) => auth.loggedIn ? Home() : SignIn(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6F35A5),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}