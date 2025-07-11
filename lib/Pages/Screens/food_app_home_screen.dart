// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:offline_image_upload/Pages/Screens/view_all_screen.dart';
import 'package:offline_image_upload/Widgets/products_items_display.dart';
import 'package:offline_image_upload/models/categories_model.dart';
import 'package:offline_image_upload/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  late Future<List<FoodModel>> futureFoodProducts = Future.value([]);
  List<CategoryModel> categories = [];
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategory = categories.first.name;
          futureFoodProducts = fetchFoodProduct(selectedCategory!);
          // fetch food products
        });
      }
    } catch (error) {
      print("Initialization Error: $error");
    }
  }
  // to fetch product data from supabase

  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final response = await Supabase.instance.client
          .from("food-product")
          .select()
          .eq("category", category);
      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (error) {
      print("Error fetching product : $error");
      return [];
    }
  }

  // to fetch category data from supabase
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response =
          await Supabase.instance.client.from("category_item").select().order('position', ascending: true); 
      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (error) {
      print("Error fetching categories : $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarParts(),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBanners(),
                  SizedBox(height: 20),
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildCategoryList(),
            SizedBox(height: 20),
            viewAll(),
            SizedBox(height: 20),
            _buildProductSection(), // this will now return a fixed height widget
            SizedBox(height: 20), // add spacing at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return SizedBox(
      height: 270, // fixed height for horizontal list
      child: FutureBuilder<List<FoodModel>>(
        future: futureFoodProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final List<FoodModel> products = snapshot.data ?? [];

          if (products.isEmpty) {
            return Center(child: Text("No Products Found"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,

            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: index == products.length - 1 ? 25 : 0,
                ),
                child: ProductsItemsDisplay(foodModel: products[index]),
              );
            },
          );
        },
      ),
    );
  }

  Padding viewAll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular now",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ViewAllProductScreen()),
              );
            },
            child: Row(
              children: [
                Text("View All", style: TextStyle(color: Colors.orange)),
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink();
        }
        return SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () => handelCategorytap(category.name),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          selectedCategory == category.name
                              ? Colors.red
                              : const Color.fromARGB(208, 227, 219, 219),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            category.image,
                            width: 20,
                            height: 20,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.fastfood),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          category.name,
                          style: TextStyle(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handelCategorytap(String category) {
    if (selectedCategory == category) return;
    setState(() {
      selectedCategory = category;
      // fetch food products
      futureFoodProducts = fetchFoodProduct(category);
    });
  }

  Container appBanners() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 210, 171),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: "The Fastest In Delivery",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Food',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  child: Text(
                    'Order Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/food-delivery/courier.png'),
        ],
      ),
    );
  }

  AppBar appbarParts() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(235, 251, 250, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/icon/dash.png'),
        ),
        Spacer(),
        Row(
          children: [
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
        Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(235, 251, 250, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/profile.png'),
        ),
        SizedBox(width: 25),
      ],
    );
  }
}
