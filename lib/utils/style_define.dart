
import 'package:demo/utils/color_define.dart';
import 'package:flutter/material.dart';

class StyleDefine {
  static TextStyle style08SimboldSecond = TextStyle(
      fontSize: 8.0,
      fontFamily: 'Roboto',
      color: ColorDefine.colorBlue,
      fontWeight: FontWeight.w600);

  //Handle Color
  static TextStyle style242Regular(Color color) {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 24.0,
        color: color,
        fontFamily: 'Roboto');
  }

  static TextStyle style14Bolod(Color color) {
    return TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14.0,
        color: color,
        fontFamily: 'Roboto');
  }

  static TextStyle style14BoldCustom(Color color, FontWeight fontWeight) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: 13.0,
        color: color,
        fontFamily: 'Roboto');
  }
}
