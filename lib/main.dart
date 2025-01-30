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
        fontFamily: 'Roboto', // Apply Roboto globally
      ),
      initialRoute: '/', // Default route when app starts
      routes: {
        '/': (context) => const HomeScreen(), // Home Page
        // '/login': (context) => const LoginScreen(), // Login Page
        '/product': (context) => const ProductDetailScreen(), // Product Page
        '/cart': (context) => const CartScreen(), // Cart Page
        '/profile': (context) => const ProfileScreen(), // Profile Page
        // '/signup': (context) => const SignupScreen(), // Signup Page
        '/report': (context) => const ReportProductScreen(), // Report Page
      },
    );
  }
}
