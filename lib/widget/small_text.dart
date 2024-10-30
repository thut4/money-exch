import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  const BigText(
      {super.key,
      required this.textName,
      this.color = const Color(0xFF424242),
      this.fontWeight = FontWeight.w600,
      this.fontSize = 20,
      this.textOverflow = TextOverflow.fade,
      this.textAlgin = TextAlign.start});
  final String textName;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlgin;
  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          overflow: textOverflow,
          fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText({
    super.key,
    required this.textName,
    this.color = const Color(0xFF424242),
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    this.softWarp = true,
    this.textAlgin = TextAlign.start,
    this.textOverflow = TextOverflow.fade,
    this.textDecoration = TextDecoration.none,
  });
  final String textName;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlgin;
  final TextDecoration textDecoration;
  final TextOverflow textOverflow;
  final bool softWarp;
  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: softWarp,
      textName,
      textAlign: textAlgin,
      style: TextStyle(
          decoration: textDecoration,
          fontSize: fontSize,
          color: color,
          overflow: textOverflow,
          fontWeight: fontWeight,
          fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }
}
