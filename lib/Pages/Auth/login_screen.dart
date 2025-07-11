import 'package:flutter/material.dart';
import 'package:offline_image_upload/Pages/Auth/sinup_screen.dart';
import 'package:offline_image_upload/Pages/Screens/onboarding_screen.dart';
import 'package:offline_image_upload/Service/auth_service.dart';
import 'package:offline_image_upload/Widgets/my_button.dart';
import 'package:offline_image_upload/Widgets/snac_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid email, it must contain .com",Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await _authService.login(email, password);

    setState(() {
      isLoading = false;
    });

    if (result == "success") {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Login successful!",Colors.green);
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Login failed: $result",Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/3094352.jpg",
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
                    child: MyButton(ontap: login, buttonText: "Login"),
                  ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have an account ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SignupScreen()),
                      );
                    },
                    child: const Text(
                      "Signup here ",
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
