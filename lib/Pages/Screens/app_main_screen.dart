import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:offline_image_upload/Core/Provider/cart_provider.dart';
import 'package:offline_image_upload/Pages/Screens/User_Activity/cart_screen.dart';
import 'package:offline_image_upload/Pages/Screens/User_Activity/favorite_screen.dart';
import 'package:offline_image_upload/Pages/Screens/food_app_home_screen.dart';
import 'package:offline_image_upload/Pages/Screens/profile_screen.dart';

class AppMainScreen extends ConsumerStatefulWidget {
  const AppMainScreen({super.key});

  @override
  ConsumerState<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends ConsumerState<AppMainScreen> {
  int currentIndex = 0;
  final List<Widget> _pages = [
    FoodAppHomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
    CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    CartProvider cp = ref.watch(cartProvider);
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItems(Iconsax.home_15, "A", 0),
            SizedBox(width: 10),
            _buildNavItems(Iconsax.heart, "B", 1),
            SizedBox(width: 90),
            _buildNavItems(Icons.person_outline, "C", 2),
            SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, "D", 3),
                Positioned(
                  right: -7,
                  top: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      cp.items.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Positioned(
                  right: 138,
                  top: -25,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 35,
                    child: Icon(
                      CupertinoIcons.search,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // helper method to create a bottom navigation item
  Widget _buildNavItems(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? Colors.red : Colors.grey,
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor:
                currentIndex == index ? Colors.red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
