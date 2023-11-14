import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness:  Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade600,
    onSecondary: Colors.black
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black
  )
);
