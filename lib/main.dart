import 'package:aura_app/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:aura_app/Screens/homescreen.dart';
import 'package:aura_app/Screens/login.dart';
import 'package:aura_app/Screens/product.dart';
import 'package:aura_app/Screens/signup.dart';
import 'package:aura_app/Screens/cart.dart';
import 'package:aura_app/Screens/profile.dart';
import 'package:aura_app/Screens/report.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Default text color
          bodyMedium: TextStyle(color: Colors.black), // Secondary text
        ),
      ),

      // Define Dark Theme
      darkTheme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white), // Default text color for dark mode
          bodyMedium: TextStyle(color: Colors.white70), // Secondary text
        ),
      ),

      // Automatically respond to system settings
      themeMode: ThemeMode.system,

      // Define routes
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/product': (context) => const ProductDetailScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/signup': (context) => const SignupScreen(),
        '/report': (context) => const ReportProductScreen(),
      },
    );
  }
}
