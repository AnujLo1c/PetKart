import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  primary: Color(0xFFF37D84),
  onPrimary: Colors.white,
  secondary: Color(0xFFF3B0B4),
  onSecondary: Color(0xFF48484C),
  error: Colors.redAccent,
  onError: Colors.white,
  surface: Color(0xFFFAFBFB),
  onSurface: Color(0xFF241E30),
  brightness: Brightness.light,
  shadow: Color(0xFFEAC8CA),
  outline: Color(0xFFF37D84)
);

const  ColorScheme darkColorScheme = ColorScheme(
  primary: Color(0xFFBB86FC),
  secondary: Color(0xFFD7BEF6),
  surface: Color(0xFF1F1929),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.black,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  brightness: Brightness.dark,
  shadow:  Colors.black12,
  // shadow: Color(0xFFEAC8CA),
  outline: Colors.white
);
