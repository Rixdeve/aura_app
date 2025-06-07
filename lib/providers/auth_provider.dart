import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../db/user_db.dart';

class AuthProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? _token;
  Map<String, dynamic>? _user;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(
          'https://mediumpurple-barracuda-426225.hostingersite.com/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      _user = data['user'];

      await storage.write(key: 'jwt_token', value: _token);

      final userModel = UserModel.fromJson(_user!);
      await UserDatabase.instance.insertUser(userModel);

      final savedUser = await UserDatabase.instance.getUser();
      if (savedUser != null) {
        print("SQFLite Saved User: ${savedUser.name} (${savedUser.email})");
      } else {
        print("No user found.");
      }

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(String name, String email, String phone, String password,
      String confirmPassword) async {
    final response = await http.post(
      Uri.parse(
          'https://mediumpurple-barracuda-426225.hostingersite.com/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['token'];
      _user = data['user'];

      await storage.write(key: 'jwt_token', value: _token);

      // Save user to SQLite
      final userModel = UserModel.fromJson(_user!);
      await UserDatabase.instance.insertUser(userModel);

      final savedUser = await UserDatabase.instance.getUser();
      if (savedUser != null) {
        print("SQFLite Saved User: ${savedUser.name} (${savedUser.email})");
      } else {
        print("No user found in DB.");
      }

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    await storage.delete(key: 'jwt_token');
    await UserDatabase.instance.clearUser();
    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await storage.read(key: 'jwt_token');
    notifyListeners();
  }
}
