import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;
  final bool keepOriginalSize;
  final double fontsize;

  CustomText(
      {required this.text,
      this.fontsize = 18,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center,
      this.maxLines = 1,
      this.keepOriginalSize = false});
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        fontSize: fontsize,
        color: textColor,
        fontWeight: fontWeight);
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
