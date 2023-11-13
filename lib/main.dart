import 'package:flutter/material.dart';
import 'package:pokemon_api/presentation/pages/home_page.dart';
import 'package:pokemon_api/presentation/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomePage()
    );
  }
}
