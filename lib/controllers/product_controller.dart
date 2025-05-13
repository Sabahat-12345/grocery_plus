import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/grocery_model.dart';
import '../constants/colors.dart';

class ProductDetailController extends GetxController {
  var isLoading = false.obs;
  var inWishList = false.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addToCart(Items item) async {
    isLoading.value = true;
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(item.productId)
          .set(item.toJson());
      Get.snackbar("Success", "Item added to cart",
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToWishList(Items item) async {
    isLoading.value = true;
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(item.productId)
          .set(item.toJson());
      inWishList.value = true;
      Get.snackbar("Success", "Item added to wishlist",
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromWishList(String productId) async {
    isLoading.value = true;
    try {
      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(productId)
          .delete();
      inWishList.value = false;
      Get.snackbar("Removed", "Item removed from wishlist",
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkWishList(String productId) async {
    try {
      var docSnapshot = await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(productId)
          .get();
      inWishList.value = docSnapshot.exists;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
