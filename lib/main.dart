import 'package:aura_app/Screens/profile.dart';
import 'package:aura_app/Screens/homescreen.dart';
import 'package:aura_app/Screens/login.dart';
import 'package:aura_app/Screens/product.dart';
import 'package:aura_app/Screens/signup.dart';
import 'package:aura_app/Screens/cart.dart';
import 'package:aura_app/Screens/profile.dart';
import 'package:aura_app/Screens/report.dart';
import 'package:aura_app/Screens/about_us.dart';
import 'package:aura_app/utils/network_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aura_app/providers/cart_provider.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'package:provider/provider.dart';
import './utils/network_status.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NetworkStatusNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _accelerometerSubscription;
  final double shakeThreshold = 15.0;
  List<double> _lastValues = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    _startShakeListener();
  }

  void _startShakeListener() {
    _accelerometerSubscription = accelerometerEvents.listen((event) async {
      double dx = event.x - _lastValues[0];
      double dy = event.y - _lastValues[1];
      double dz = event.z - _lastValues[2];

      double delta = dx.abs() + dy.abs() + dz.abs();

      if (delta > shakeThreshold) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.logout();

        print("Navigating to Login.");
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/', (route) => false);
      }

      _lastValues = [event.x, event.y, event.z];
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/product': (context) {
          final String productId =
              ModalRoute.of(context)?.settings.arguments as String? ??
                  'someProductId';
          return ProductDetailScreen(productId: productId);
        },
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/signup': (context) => const SignupScreen(),
        '/report': (context) {
          final int orderId = ModalRoute.of(context)?.settings.arguments as int;
          return ReportProductScreen(orderId: orderId);
        },
        '/about': (context) => const AboutUsPage(),
      },
    );
  }
}
