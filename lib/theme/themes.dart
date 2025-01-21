import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF7565E6);
const Color secondaryColor = Colors.white;
const Color backgroundColor = Color(0xFF0D0F11);

TextTheme get textTheme {
  return const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Jersey10',
      fontSize: 66,
      color: secondaryColor,
      fontWeight: FontWeight.w400,
      height: 1.0,
      // 66px line-height = 1.0 for 66px font-size
      textBaseline: TextBaseline.alphabetic,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.0,
      decorationColor: Colors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Jersey10',
      fontSize: 44,
      fontWeight: FontWeight.w400,
      height: 1.0,
      textBaseline: TextBaseline.alphabetic,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.0,
      decorationColor: Colors.black,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Jersey10',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.0,
      textBaseline: TextBaseline.alphabetic,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.0,
      decorationColor: Colors.black,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 64,
      // Example size for headlineLarge
      fontWeight: FontWeight.w500,
      height: 1.25,
      // Adjust based on desired line-height
      letterSpacing: -0.5,
      // Adjust based on desired tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none, // No underline for this style
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 48,
      // Example size for TitleLarge
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      height: 1.25,
      // Adjust based on TitleLargeLineHeight
      letterSpacing: -0.4,
      // Adjust based on TitleLargeTracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 32,
      // Example size for headlineSmall
      fontWeight: FontWeight.w500,
      height: 1.25,
      // Adjust based on desired line-height
      letterSpacing: -0.3,
      // Adjust based on desired tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 72,
      fontWeight: FontWeight.w500,
      height: 1.3,
      letterSpacing: -0.2,
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 60, // Example size for Headline Medium
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      height: 1.3, // Example line-height ratio
      letterSpacing: -0.15, // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 48, // Example size for displaySmall
      fontWeight: FontWeight.w500,
      height: 1.3, // Example line-height ratio
      letterSpacing: -0.1, // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 20, // Example size for bodyLarge
      fontWeight: FontWeight.w500,
      height: 1.5, // Example line-height ratio
      letterSpacing: 0.15, // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16, // Example size for Title Medium
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      height: 1.4, // Example line-height ratio
      letterSpacing: 0.1, // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14, // Example size for bodySmall
      fontWeight: FontWeight.w500,
      height: 1.3, // Example line-height ratio
      letterSpacing: 0.05, // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
  );
}

ButtonStyle get elevatedButtonStyle {
  return ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
    minimumSize: const Size(250, 50),
    maximumSize: const Size(300, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
    )
  );
}

ButtonStyle get textButtonStyle {
  return TextButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    foregroundColor: primaryColor, // Text color
    elevation: 0, // No elevation
    shape: const RoundedRectangleBorder(), // No shape customization
  );
}

InputDecorationTheme get inputDecorationTheme {
  return const InputDecorationTheme(
    filled: true, // Enables background fill color
    fillColor: Color(0xFF181C1F), // Background color
    contentPadding: EdgeInsets.only(left: 10, top: 10), // Padding inside the input field
    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10), // Top left corner rounded
        topRight: Radius.zero, // Top right corner not rounded
        bottomLeft: Radius.zero, // Bottom left corner not rounded
        bottomRight: Radius.zero, // Bottom right corner not rounded
      ),
      borderSide: BorderSide.none, // No visible border
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.zero,
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.zero,
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      borderSide: BorderSide.none,
    ),
  );
}

ThemeData get lightTheme {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark, // Dark theme for white text
      primary: primaryColor, // Accent color for buttons, etc.
      onPrimary: secondaryColor, // Text on primary color
      secondary: primaryColor, // Accent color for secondary elements
      onSecondary: secondaryColor, // Text on background
      surface: Color(0xFF1E1E1E), // Surface color for cards, sheets, etc.
      onSurface: secondaryColor, // Text on surface
      error: Color(0xFFCF6679), // Error color
      onError: secondaryColor, // Text on error color
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle,
    ),
    inputDecorationTheme: inputDecorationTheme,
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    ),
  );
}