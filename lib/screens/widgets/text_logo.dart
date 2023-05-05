import 'package:flutter/material.dart';

import '../../core/colors.dart';

class LogoText extends StatelessWidget {
  final double fontSize;
  const LogoText({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'E-',
          style: TextStyle(
            color: whiteColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: 'Store'.toUpperCase(),
              style: TextStyle(
                color: amberColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ]),
    );
  }
}
