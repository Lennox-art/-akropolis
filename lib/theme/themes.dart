import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF7565E6);
const Color secondaryColor = Colors.white;
const Color surfaceColor = Color(0xFF181C1F);
const Color onSurfaceColor = Color(0xFF424242);
const Color backgroundColor = Color(0xFF0D0F11);
const Color iconColor = Color(0xFFFEFEFE);
const Color errorColor = Color(0xFFF3473E);

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
      fontSize: 55,
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
      fontSize: 29,
      // Example size for TitleLarge
      fontWeight: FontWeight.w500,
      color: Colors.white,
      height: 1.25,
      // Adjust based on TitleLargeLineHeight
      letterSpacing: -0.4,
      // Adjust based on TitleLargeTracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24.5,
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
      fontSize: 54,
      // Example size for Headline Medium
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      height: 1.3,
      // Example line-height ratio
      letterSpacing: -0.15,
      // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 46,
      // Example size for displaySmall
      fontWeight: FontWeight.w500,
      height: 1.3,
      // Example line-height ratio
      letterSpacing: -0.1,
      // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      // Example size for bodyLarge
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Colors.white70,
      // Example line-height ratio
      letterSpacing: 0.15,
      // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      // Example size for Title Medium
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      height: 1.4,
      // Example line-height ratio
      letterSpacing: 0.1,
      // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      // Example size for bodySmall
      fontWeight: FontWeight.w500,
      height: 1.3,
      // Example line-height ratio
      letterSpacing: 0.05,
      // Example tracking
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
  );
}

ButtonStyle get elevatedButtonStyle {
  return ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      fixedSize: const Size(350, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ));
}

ButtonStyle get textButtonStyle {
  return TextButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    foregroundColor: primaryColor, // Text color
    elevation: 0, // No elevation
    shape: const RoundedRectangleBorder(), // No shape customization
  );
}

AppBarTheme get appBarTheme {
  return const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

InputDecorationTheme get inputDecorationTheme {
  return InputDecorationTheme(
    filled: true,
    // Enables background fill color
    fillColor: const Color(0xFF181C1F),
    // Background color
    contentPadding: const EdgeInsets.all(8.0),
    // Padding inside the input field
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: iconColor,
        width: 1.5,
      ),
    ),
    hintStyle: textTheme.bodyMedium,

    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: onSurfaceColor,
        width: 1.5,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide:
          BorderSide(color: primaryColor, width: 1.5), // // No visible border
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide:
          BorderSide(color: errorColor, width: 1.5), // No visible border
    ),
  );
}

IconThemeData get iconThemeData {
  return IconThemeData(
    color: iconColor,
  );
}

IconButtonThemeData get iconButtonThemeData {
  return IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(iconColor),
    ),
  );
}

ListTileThemeData get listTileThemeData {
  return ListTileThemeData(
    iconColor: iconColor,
    enableFeedback: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.5,
      letterSpacing: 0.0,
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none,
    ),
  );
}

TabBarThemeData get tabTheme {
  return TabBarThemeData(
    indicatorColor: Colors.white70,
    indicatorSize: TabBarIndicatorSize.label,
    dividerColor: Colors.white12,
    labelColor: secondaryColor,
    unselectedLabelColor: Colors.white70,
    labelStyle: textTheme.bodyMedium,
    unselectedLabelStyle: textTheme.bodySmall,
    tabAlignment: TabAlignment.start,
    textScaler: const TextScaler.linear(1),
  );
}

BottomNavigationBarThemeData get bottomNavTheme {
  return BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: secondaryColor,
    selectedItemColor: primaryColor,
    type: BottomNavigationBarType.fixed,
  );
}

CardTheme get cardTheme {
  return CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 4,
    margin: const EdgeInsets.all(8.0),
  );
}

SliderThemeData get sliderTheme {
  return SliderThemeData(
  showValueIndicator: ShowValueIndicator.always,
  );
}

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      // Dark theme for white text
      primary: primaryColor,
      // Accent color for buttons, etc.
      onPrimary: secondaryColor,
      // Text on primary color
      secondary: primaryColor,
      // Accent color for secondary elements
      onSecondary: secondaryColor,
      // Text on background
      surface: surfaceColor,
      // Surface color for cards, sheets, etc.
      onSurface: secondaryColor,
      // Text on surface
      error: Color(0xFFCF6679),
      // Error color
      onError: secondaryColor, // Text on error color
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: appBarTheme,
    tabBarTheme: tabTheme,
    sliderTheme: sliderTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle,
    ),
    listTileTheme: listTileThemeData,
    inputDecorationTheme: inputDecorationTheme,
    iconTheme: iconThemeData,
    cardTheme: cardTheme,
    iconButtonTheme: iconButtonThemeData,
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    ),
    bottomNavigationBarTheme: bottomNavTheme,
  );
}
