// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_image_upload/Core/Provider/cart_provider.dart';
import 'package:offline_image_upload/Core/Provider/favorite_provider.dart';
import 'package:offline_image_upload/Service/auth_service.dart';

final AuthService authService = AuthService();

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarParts(),
      body: Column(
        children: [
          // Logout Text
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 280),
            child: Text(
              "Logout",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Logout Button with hover effect
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color:
                      isHovered
                          ? const Color.fromARGB(255, 194, 96, 87)
                          : const Color.fromARGB(255, 255, 3, 3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isHovered
                              ? const Color.fromARGB(
                                255,
                                255,
                                77,
                                77,
                              ).withOpacity(0.6)
                              : Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    authService.logout(context);
                    ref.invalidate(favoriteProvider);
                    ref.invalidate(cartProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  child: Icon(Icons.exit_to_app, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appbarParts() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        const SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(235, 251, 250, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/icon/dash.png'),
        ),
        const Spacer(),
        Row(
          children: const [
            Icon(Icons.location_on_outlined, size: 18, color: Colors.red),
            SizedBox(width: 5),
            Text(
              'pali rajasthan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Colors.orange,
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(235, 251, 250, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/profile.png'),
        ),
        const SizedBox(width: 25),
      ],
    );
  }
}
