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
      ),
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
