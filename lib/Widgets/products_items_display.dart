// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_image_upload/Core/Provider/favorite_provider.dart';
import 'package:offline_image_upload/Pages/Screens/food_detail_screen.dart';
import 'package:offline_image_upload/models/product_model.dart';

class ProductsItemsDisplay extends ConsumerWidget {
  final FoodModel foodModel;
  const ProductsItemsDisplay({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => FoodDetailScreen(product: foodModel),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,

        children: [
          Positioned(
            bottom: 1,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Container(
                height: 180,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      spreadRadius: 10,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // for hot and fav icons
          Positioned(
            right: 1,
            top: 3,
            child: GestureDetector(
              onTap: () {
                ref.read(favoriteProvider).toggleFavorite(foodModel.name);
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor:
                    provider.isExist(foodModel.name)
                        ? Colors.red[100]
                        : Colors.transparent,
                child:
                    provider.isExist(foodModel.name)
                        ? Image.asset(
                          "assets/food-delivery/icon/fire.png",
                          height: 22,
                        )
                        : Icon(Icons.local_fire_department, color: Colors.red),
              ),
            ),
          ),
          Container(
            width: size.width * 0.5,
            padding: EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: foodModel.imageCard,
                  child: Image.network(
                    foodModel.imageCard,
                    height: 140,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    foodModel.name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  foodModel.specialItems,
                  style: TextStyle(
                    height: 0.1,
                    letterSpacing: 0.5,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "\₹",
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      TextSpan(
                        text: "${foodModel.price}",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
