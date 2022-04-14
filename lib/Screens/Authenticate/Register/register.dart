import 'package:chatbot/Services/auth.dart';
import 'package:chatbot/Shared/already_signInOrsignUp.dart';
import 'package:chatbot/Shared/divider.dart';
import 'package:chatbot/Shared/input_fields.dart';
import 'package:chatbot/Shared/loading.dart';
import 'package:chatbot/Shared/password_field.dart';
import 'package:chatbot/Shared/rounded_button.dart';
import 'package:chatbot/Shared/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String name = '';
  String phone = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return loading
      ? Loading()
      : Scaffold(
        body: Container(
              height: size.height,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/signup_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/main_bottom.png",
                      width: size.width * 0.25,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          SizedBox(height: size.height * 0.05),
                          
                          SvgPicture.asset(
                            "assets/signup.svg",
                            height: size.height * 0.30,
                          ),

                          InputField(
                            valid: (val) {
                              if (val != null) {
                                return val.length == 0
                                    ? 'Enter Your Name!'
                                    : null;
                              } else {
                                error = "Enter Your Name***";
                              }
                            },
                            changed: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                            hintText: "Your Name",
                            icon: Icons.person,
                          ),

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
                          
                          InputField(
                            valid: (val) {
                              if (val != null) {
                                return val.length < 10
                                    ? 'Invalid Phone Number!'
                                    : null;
                              } else {
                                error = "Invalid Phone Number***";
                              }
                            },
                            changed: (val) {
                              setState(() {
                                phone = val;
                              });
                            },
                            hintText: "Your Phone",
                            icon: Icons.phone,
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

                          PasswordField(
                            valid: (val) {
                              if (val != null) {
                                return val != password
                                    ? 'Password does not match!!'
                                    : null;
                              } else {
                                error = "Password does not match***";
                              }
                            },
                            changed: (val) {
                              // No requirement
                            },
                            hintText: "Re-Enter the Password",
                            icon: Icons.lock,
                          ),

                          RoundedButton(
                            pressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                
                                    dynamic result = await _auth.registerWithEmailAndPassword(
                                        email, password, name, phone);
                                if (result == null) {
                                  setState(() {
                                    error = "Please Supply a valid email***";
                                    loading = false;
                                  });
                                } 
                                // else {
                                //   //Navigator.pushNamed(context, '/NewsSubscriptionPage');
                                //   //setState(() {
                                //     //Navigator.pushNamed(context, '/Home');
                                //   //});
                                // }
                              }
                              print(error);
                            },
                            whichAuthentication: "SIGN UP",
                          ),

                          SizedBox(height: size.height * 0.01),

                          AlreadySignInOrSignUp(
                            tap: () {
                              Navigator.pushNamed(context, '/SignIn');
                            },
                            text2: "SIGN IN",
                            text1: "Already have an Account ? ",
                          ),

                          GetDivider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SocialIcon(
                                image: "assets/phone2.svg",
                                tap: () {
                                  
                                },
                              ),
                              SocialIcon(
                                image: "assets/google-plus.svg",
                                tap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithGoogle();
                                  if (result == null) {
                                    setState(() {
                                      error = "Please Supply a valid email";
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.pushNamed(context, '/Home');
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
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