import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/style/colors.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: primary,
  appBarTheme: const AppBarTheme(
    color: primary,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primary,
    selectionColor: primary,
    selectionHandleColor: primary,
  ),
);
