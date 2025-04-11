import 'package:flutter/material.dart';
import 'package:grocery_plus/constants/store_item.dart';
import 'package:grocery_plus/widgets/favorite_card_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stores = StoreItem.stores; // ✅ This will fix the error

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            return FavoriteCardWidget(
              name: store["name"]!,
              image: store["image"]!,
              rating: store["rating"]!,
              price: store["price"]!,
            );
          },
        ),
      ),
    );
  }
}
