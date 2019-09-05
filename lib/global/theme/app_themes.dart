import 'package:flutter/material.dart';

enum AppTheme {
  Dark,
  Light,
}

final appThemeData = {
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
  ),
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
  ),
};
