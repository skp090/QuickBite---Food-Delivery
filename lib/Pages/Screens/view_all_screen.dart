// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:offline_image_upload/Widgets/products_items_display.dart';
import 'package:offline_image_upload/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchFoodProduct();
  }

  // to fetch data product from supabase
  Future<void> fetchFoodProduct() async {
    try {
      final response =
          await Supabase.instance.client.from("food-product").select();
      final data = response as List;
      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching product : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.blue[50],
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: products.length,
                padding: EdgeInsets.all(16),

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.59,
                  crossAxisSpacing: 8, // 2 items per row
                ),
                itemBuilder: (context, index) {
                  return ProductsItemsDisplay(foodModel: products[index]);
                },
              ),
    );
  }
}
