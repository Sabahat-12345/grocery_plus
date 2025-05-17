import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/controllers/cart_controller.dart';

import 'package:grocery_plus/widgets/cart_widget.dart';
import 'package:grocery_plus/widgets/primary_button.dart';
import 'package:grocery_plus/screens/bottom_Nav_bar.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => BottomNavBar()),
            );
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: PrimaryButton(
          title: "Buy Now",
          icon: Icons.shopping_bag,
          ontap: () {
            // Add future action here
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (cartController.cartItems.isEmpty) {
              return const Center(child: Text("No items in cart"));
            }
            return ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                var item = cartController.cartItems[index];
                return CartWidget(
                  items: item,
                  onDelete: () {
                    cartController.deleteCartItem(item.productId);
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
