import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  
  IconData icon;
  String hintText;
  void Function(String) changed;
  String Function(String) valid;

  PasswordField({this.hintText, this.icon,  this.changed, this.valid});
  
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool showPassword = true;
  bool suffixIcon = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height*0.00609),
      padding: EdgeInsets.symmetric(horizontal: size.width*0.0486, vertical: size.height*0.00365),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xFFF1E6FF),
        borderRadius: BorderRadius.circular(size.height*0.0353),
      ),
      child: TextFormField(
        validator: widget.valid,
        obscureText: showPassword,
        onChanged: widget.changed,
        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            widget.icon,
            color: Color(0xFF6F35A5),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
                suffixIcon = !suffixIcon;
              });
            },
            child: Icon(
              suffixIcon == true ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF6F35A5),
              
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
