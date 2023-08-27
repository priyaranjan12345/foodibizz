import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

///This class defines light theme and dark theme
///Here we used flex color scheme
class AppThemes {
  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
      );
  static ThemeData get darkTheme => FlexThemeData.dark(
        useMaterial3: true,
      );
}
