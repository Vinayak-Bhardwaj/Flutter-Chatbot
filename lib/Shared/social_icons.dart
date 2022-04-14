import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {
  String image;
  void Function() tap;
  SocialIcon({ this.image,  this.tap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width*0.0364),
        padding: EdgeInsets.all(size.width*0.04866),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color(0xFFF1E6FF),
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          image,
          height: size.height*0.0243,
          width: size.width*0.04866,
        ),
      ),
    );
  }
}
