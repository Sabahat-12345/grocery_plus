import 'package:flutter/material.dart';
import 'package:grocery_plus/constants/product_item.dart';
import 'package:grocery_plus/widgets/cart_widget.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = ProductItem.products;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: PrimaryButton(
          title: "Buy Now",
          icon: Icons.shopping_bag,
          ontap: () {
            // Add your button logic here
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return CartWidget(
                name: product["name"]!,
                image: product["image"]!,
                rating: product["rating"]!,
                price: product["price"]!,
              );
            },
          ),
        ),
      ),
    );
  }
}
