import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ).apply(
      fontFamily: 'SFProText',
    ),
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
     
      selectedItemColor: Color(0xFFB45A9B),
      unselectedItemColor: Color(0xFF000000),
      unselectedLabelStyle: TextStyle(
      color:Color(0xFF000000), fontWeight: FontWeight.w400, fontSize: 10
      ),
      selectedLabelStyle: TextStyle(
          color: Color(0xFFB45A9B), fontWeight: FontWeight.w400, fontSize: 10),
    ),
    useMaterial3: true,
  );
}
