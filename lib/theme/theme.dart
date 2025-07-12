import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  const gsColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF008081),

    onPrimary: Colors.white,

    secondary: Colors.orange,

    onSecondary: Colors.black,

    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    outline: Color(0xFF777777),
  );

  final baseTextTheme = GoogleFonts.openSansTextTheme();

  return ThemeData(
    colorScheme: gsColorScheme,
    textTheme: baseTextTheme.copyWith(
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: gsColorScheme.primary),
    ),
    primaryIconTheme: IconThemeData(color: gsColorScheme.primary),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        // same 5-px radius everywhere
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        // 43-px tall buttons
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 43)),
        // Primary colour when enabled, grey when disabled
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.disabled) ? Colors.grey : gsColorScheme.primary,
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.white),
    useMaterial3: true,
  );
}

ThemeData darkTheme() {
  const gsColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF008081),

    onPrimary: Colors.white,

    secondary: Colors.orange,

    onSecondary: Colors.white,

    error: Colors.red,
    onError: Colors.white,
    surface: Color(0xFF0f1217),
    onSurface: Colors.black,
    outline: Color(0xFF777777),
  );

  final baseTextTheme = GoogleFonts.openSansTextTheme();

  return ThemeData(
    colorScheme: gsColorScheme,
    textTheme: baseTextTheme.copyWith(
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: gsColorScheme.primary),
    ),
    primaryIconTheme: IconThemeData(color: gsColorScheme.primary),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        // same 5-px radius everywhere
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        // 43-px tall buttons
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 43)),
        // Primary colour when enabled, grey when disabled
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.disabled) ? Colors.grey : gsColorScheme.primary,
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.white),
    useMaterial3: true,
  );
}
