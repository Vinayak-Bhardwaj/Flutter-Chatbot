import 'package:chatbot/Services/auth.dart';
import 'package:chatbot/Shared/already_signInOrsignUp.dart';
import 'package:chatbot/Shared/input_fields.dart';
import 'package:chatbot/Shared/loading.dart';
import 'package:chatbot/Shared/password_field.dart';
import 'package:chatbot/Shared/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();

  //Declaring variables
  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              width: double.infinity,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/login_bottom.png",
                      width: size.width * 0.4,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text("e-Com Pirates", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Billabong', fontSize: 60)),
                          SizedBox(height: 30),
                          SvgPicture.asset(
                            "assets/login.svg",
                            height: size.height * 0.35,
                          ),
                          SizedBox(height: size.height * 0.03),
                          InputField(
                            valid: (val) {
                              if (val != null) {
                                return val.isEmpty ? 'Enter an Email!!' : null;
                              } else {
                                error = "Enter an Email***";
                              }
                            },
                            changed: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            hintText: "Your Email",
                            icon: Icons.email,
                          ),
                          PasswordField(
                            valid: (val) {
                              if (val != null) {
                                return val.length < 6
                                    ? 'Enter the password 6+ chars long!!'
                                    : null;
                              } else {
                                error = "Enter the password 6+ chars long***";
                              }
                            },
                            changed: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            hintText: "Password",
                            icon: Icons.lock,
                          ),
                          RoundedButton(
                            pressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "Please supply a valid email";
                                    loading = false;
                                  });
                                } else {
                                  //Navigator.pushNamed(context, '/Home');
                                }
                              }
                            },
                            whichAuthentication: "LOGIN",
                          ),
                          SizedBox(height: size.height*0.0121),
                          AlreadySignInOrSignUp(
                            tap: () {
                              //print('Im inside tap');
                              Navigator.pushNamed(context, '/Register');
                            },
                            text2: "SIGN UP",
                            text1: "Don’t have an Account ?",
                          ),
                          SizedBox(height: size.height*0.00609),
                          Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
