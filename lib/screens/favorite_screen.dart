import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/controllers/favorite_controller.dart';
import 'package:grocery_plus/widgets/favorite_card_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (favoriteController.favoriteItems.isEmpty) {
            return const Center(child: Text("No items in wishlist"));
          }

          return ListView.builder(
            itemCount: favoriteController.favoriteItems.length,
            itemBuilder: (context, index) {
              var items = favoriteController.favoriteItems[index];
              return FavoriteCardWidget(
                items: items,
                onDelete: () {
                  favoriteController.deleteWishListItem(items.productId);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
