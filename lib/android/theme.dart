import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = Color(0xff424242);
const accentColor = Colors.white;
const buttonColor = Color(0xfff5f5f5);

ThemeData theme() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    accentColor: accentColor,
    buttonColor: buttonColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black54,
      ),
    ),
    textTheme: TextTheme(
      body1: TextStyle(
        fontFamily: "Poppins",
      ),
      body2: TextStyle(
        fontFamily: "Poppins",
      ),
      button: TextStyle(
        fontFamily: "Poppins",
      ),
      caption: TextStyle(
        fontFamily: "Poppins",
      ),
      display1: TextStyle(
        fontFamily: "Poppins",
      ),
      display2: TextStyle(
        fontFamily: "Poppins",
      ),
      display3: TextStyle(
        fontFamily: "Poppins",
      ),
      display4: TextStyle(
        fontFamily: "Poppins",
      ),
      overline: TextStyle(
        fontFamily: "Poppins",
      ),
      headline: TextStyle(
        fontFamily: "Poppins",
      ),
      subhead: TextStyle(
        fontFamily: "Poppins",
      ),
      subtitle: TextStyle(
        fontFamily: "Poppins",
      ),
      title: TextStyle(
        fontFamily: "Poppins",
      ),
    ),
  );
}
