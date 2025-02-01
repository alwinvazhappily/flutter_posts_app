import 'package:flutter/material.dart';
import 'package:flutter_posts_app/core/theme/app_pallete.dart';
import 'package:flutter_posts_app/core/theme/text_theme.dart';

class AppTheme {
  static final _colorScheme =
      ColorScheme.fromSeed(seedColor: Pallete.seedColor);

  static final ThemeData lightThemeMode = ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,
    brightness: Brightness.light,
    textTheme: _lightTextTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: _colorScheme.secondary,
      foregroundColor: _colorScheme.onSecondary,
      titleTextStyle: _lightTextTheme.labelLarge,
    ),
  );

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: CustomTextTheme.displayLargeLight, // headline 1
    displayMedium: CustomTextTheme.displayMediumLight, // headline 2
    displaySmall: CustomTextTheme.displaySmallLight, // headline 3
    headlineMedium: CustomTextTheme.headlineMediumLight, // headline 4
    headlineSmall: CustomTextTheme.headlineSmallLight,
    titleMedium: CustomTextTheme.titleMediumLight, // subtitle 1
    titleSmall: CustomTextTheme.titleSmallLight, // subtitle 2
    bodyLarge: CustomTextTheme.bodyLargeLight, // body Text 1
    bodyMedium: CustomTextTheme.bodyMediumLight, // bodyText 2
    bodySmall: CustomTextTheme.bodySmallLight, // caption
    labelLarge: CustomTextTheme.labelLargeLight, // button
    labelSmall: CustomTextTheme.labelSmallLight, // overline
  );
}
