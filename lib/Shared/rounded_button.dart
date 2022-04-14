import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String whichAuthentication;
  void Function() pressed;

  RoundedButton({ this.whichAuthentication,  this.pressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height*0.01219),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.height*0.0353),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: size.height*0.0243, horizontal: size.width*0.0973),
            primary: Color(0xFF6F35A5),
            backgroundColor: Color(0xFF6F35A5),
            onSurface: Color(0xFF6F35A5),
          ),
          onPressed: pressed,
          child: Text(
            whichAuthentication,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
