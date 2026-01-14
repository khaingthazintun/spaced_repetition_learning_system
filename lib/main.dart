import 'package:flutter/material.dart';
import 'package:spaced_repetition_learning_system/screens/splash_screen.dart';

void main() {
  runApp(const SRSLearningApp());
}

class SRSLearningApp extends StatelessWidget {
  const SRSLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SRS Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Text',
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        colorScheme: const ColorScheme.dark(
          surface: Color(0x08FFFFFF),
          primary: Color(0xFF5DD6FF),
          secondary: Color(0xFF6EE7B7),
          tertiary: Color(0xFFFFD166),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            color: Color(0xFFE6EDF7),
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            color: Color(0xFF9FB0C7),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFF9FB0C7),
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            color: Color(0xFF9FB0C7),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0x1A5DD6FF),
            foregroundColor: const Color(0xFFE6EDF7),
            side: const BorderSide(color: Color(0x595DD6FF)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}