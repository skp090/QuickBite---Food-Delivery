// lib/Pages/Auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:offline_image_upload/Pages/Auth/login_screen.dart';
import 'package:offline_image_upload/Service/auth_service.dart';
import 'package:offline_image_upload/Widgets/my_button.dart';
import 'package:offline_image_upload/Widgets/snac_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid email, it must contain .com", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await _authService.signup(email, password);

    setState(() {
      isLoading = false;
    });

    if (result == "success") {
      // ignore: use_build_context_synchronously
      showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        "Signup successful! You can now login.",
        Colors.green,
      );
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Signup failed: $result", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/6343825.jpg",
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                    width: double.infinity,
                    child: MyButton(ontap: signUp, buttonText: "Signup"),
                  ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Already have an account ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login here ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
