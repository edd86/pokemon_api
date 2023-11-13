import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFC40135),
          onPrimary: Color(0xFFFBEDF0),
          secondary: Color(0xFF324b72),
          onSecondary: Color(0xFFC0FAFF),
          error: Color(0xFF574141),
          onError: Color(0xFF574141),
          background: Color(0xFFFFF6F5),
          onBackground: Color(0xFF574141),
          surface: Color(0xFFFFE4E2),
          onSurface: Color(0xFFAE1963),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 5,
          shadowColor: Color(0xFF574141)
        )
      );
}
