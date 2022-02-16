import 'package:flutter/material.dart';

ThemeData _themeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: Colors.blueGrey,
      primaryContainer: Colors.lightBlue,
      secondary: Colors.amber,
      secondaryContainer: Colors.amber,
      surface: Colors.blueGrey,
      background: Colors.black,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.amber,
      onSurface: Colors.blueGrey,
      onBackground: Colors.grey,
      onError: Colors.red,
      brightness: Brightness.light,
    ),
  );
}

Theme themed(BuildContext context, Widget child) {
  return Theme(
    data: _themeData(context),
    child: child,
  );
}

TextStyle drawerTextStyle() {
  return const TextStyle(color: Colors.blueGrey, fontSize: 25);
}

TextStyle playerAnzeigeStyle(double size) {
  return TextStyle(
      color: const Color(0xFF37474F),
      fontWeight: FontWeight.bold,
      fontSize: size);
}
