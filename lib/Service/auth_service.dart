// lib/Service/auth_service.dart
import 'package:flutter/material.dart';
import 'package:offline_image_upload/Pages/Auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> signup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      // ignore: avoid_print
      print("Signup response: user=${response.user}, session=${response.session}");
      if (response.user != null) {
        return "success";
      } else {
        return "Signup failed.";
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        return "success";
      } else {
        return "Login failed.";
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
        if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } on AuthException catch (e) {
      // ignore: avoid_print
      print('Logout error: ${e.message}');
    } catch (e) {
      // ignore: avoid_print
      print('Unexpected logout error: $e');
    }
  }

  bool isLoggedIn() {
    return supabase.auth.currentUser != null;
  }
}
