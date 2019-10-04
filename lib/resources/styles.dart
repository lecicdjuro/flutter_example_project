import 'package:flutter/material.dart';
import 'package:flutter_example_app/resources/fonts.dart' as fonts;

class OpenSansStyle extends TextStyle {
  const OpenSansStyle(
      {double fontSize,
      FontWeight fontWeight,
      Color color,
      double letterSpacing,
      double height,
      TextDecoration decoration})
      : super(
            inherit: false,
            color: color,
            fontFamily: fonts.openSans,
            fontSize: fontSize,
            fontWeight: fontWeight,
            textBaseline: TextBaseline.alphabetic,
            letterSpacing: letterSpacing,
            height: height,
            decoration: decoration);
}
