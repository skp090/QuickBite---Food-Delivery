// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_image_upload/Core/Provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    var discountPrice = (cart.totalPrice * 0.1);
    var grandTotal = (cart.totalPrice - discountPrice + 30).toStringAsFixed(2);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('Your Cart'),
      ),
      body:
          cart.items.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final items = cart.items[index];
                        return Dismissible(
                          key: Key(items.id),
                          onDismissed: (_) => cart.removeitem(items.id),
                          background: Container(color: Colors.red),
                          child: ListTile(
                            leading: Image.network(
                              items.productData['imageCard'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              items.productData['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text("\₹${(items.productData['price'])}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap:
                                      items.quantity > 1
                                          ? () {
                                            cart.addCart(
                                              items.productId,
                                              items.productData,
                                              -1,
                                            );
                                          }
                                          : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.symmetric(
                                      horizontal: BorderSide(),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      "${items.quantity}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cart.addCart(
                                      items.productId,
                                      items.productData,
                                      1,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              "swipe to remove items ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 214, 86, 77),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Total ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            "\₹${cart.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Shipping Charge",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            "(+) \₹30",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        ListTile(
                          title: Text(
                            "Discount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            "(-) 10% = \₹${discountPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            "GrandTotal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                          trailing: Text(
                            "\₹$grandTotal",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
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
