import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_plus/Models/grocery_model.dart';
import 'package:grocery_plus/constants/store_item.dart';
import 'package:grocery_plus/widgets/favorite_card_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // final stores = StoreItem.stores;
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Stream<List<Items>> getCartItems() {
    return firestore
        .collection('users') // fixed casing (was 'Users')
        .doc(auth.currentUser!.uid)
        .collection("cartItems")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList());
  }

  Future<void> deleteCardItem(String productId) async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(productId)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder(
            stream: getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text("No items in cart"),
                );
              }
              final cartItems = snapshot.data!;

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return FavoriteCardWidget(
                    items: item,
                    onDelete: () {
                      deleteCardItem(item.productId);
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
