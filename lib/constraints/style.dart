import 'package:flutter/material.dart';

class AppStyle {
  // Colors
  static AppColors colors = AppColors();

  // Border Radius
  static BorderRadius borderRadius = BorderRadius.circular(12);
  static BorderRadius bottomAppBarBorderRadius = const BorderRadius.vertical(top: Radius.circular(12));

  // Padding
  static EdgeInsets padding = const EdgeInsets.all(12);
  static EdgeInsets bottomAppBarPadding = const EdgeInsets.fromLTRB(12, 2, 12, 24);

  static TextStyle bigTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: colors.black,
  );
}

class AppColors {
  Color darkBlue = const Color(0xFF1F4690);
  Color black = const Color(0xFF1E1E1E);
  Color red = const Color(0xFFFF2A2A);
  Color lightGrey = const Color(0xFFF0F0F0);
  Color darkGrey = const Color(0xFFA7A7A7);
  Color backgroundGrey = const Color(0xFFF5F5F5);
}
