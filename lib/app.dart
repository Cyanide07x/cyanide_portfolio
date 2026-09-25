import 'package:flutter/material.dart';
import 'screens/intro/intro_page.dart';
import 'theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Cynx Portfolio',

      theme: AppTheme.dark,

      home: const IntroPage(),
    );
  }
}