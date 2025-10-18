import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  final lightColorScheme = SeedColorScheme.fromSeeds(
    primaryKey: Color(0xFF008081),
    primary: Color(0xFF008081),
    brightness: Brightness.light,
    secondaryKey: Colors.orange,
    secondary: Colors.orange,
    tones: FlexTones.vivid(Brightness.light),
  );

  final baseTextTheme = GoogleFonts.robotoMonoTextTheme();

  return ThemeData(
    colorScheme: lightColorScheme,
    textTheme: baseTextTheme.copyWith(
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: lightColorScheme.primary),
    ),
    primaryIconTheme: IconThemeData(color: lightColorScheme.primary),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        // same 5-px radius everywhere
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        // 43-px tall buttons
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 43)),
        // Primary colour when enabled, grey when disabled
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.disabled) ? Colors.grey : lightColorScheme.primary,
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColorScheme.surfaceContainer,
      focusColor: lightColorScheme.surface,
    ),
    useMaterial3: true,
  );
}

ThemeData darkTheme() {
  final darkColorScheme = SeedColorScheme.fromSeeds(
    primaryKey: Color(0xFF008081),
    primary: Color(0xFF008081),
    brightness: Brightness.dark,
    secondaryKey: Colors.orange,
    secondary: Colors.orange,
    tones: FlexTones.vivid(Brightness.dark),
  );

  final baseTextTheme = GoogleFonts.robotoMonoTextTheme();

  return ThemeData(
    colorScheme: darkColorScheme,
    textTheme: baseTextTheme.copyWith(
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: darkColorScheme.primary),
    ),
    primaryIconTheme: IconThemeData(color: darkColorScheme.primary),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        // same 5-px radius everywhere
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        // 43-px tall buttons
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 43)),
        // Primary colour when enabled, grey when disabled
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.disabled) ? Colors.grey : darkColorScheme.primary,
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkColorScheme.surfaceContainer,
      focusColor: darkColorScheme.surface,
    ),
    useMaterial3: true,
  );
}
