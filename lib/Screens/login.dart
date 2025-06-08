import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final auth = Provider.of<AuthProvider>(context, listen: false);
      final success = await auth.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your email" : null,
              ),
              const SizedBox(height: 10),
              const Text("Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your password" : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Text("Login",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text("Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
