import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/Models/grocery_model.dart';
import 'package:grocery_plus/screens/bottom_Nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadItemsController extends GetxController {
  var imageFile = Rxn<XFile>();
  final ImagePicker picker = ImagePicker();
  var firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> pickImage() async {
    try {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        imageFile.value = selectedImage;
        Get.snackbar("Image Selected", "You have picked an image.",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error while picking image: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void uploadData(String name, String price, String description) async {
    isLoading.value = true;
    try {
      var productId = const Uuid().v1();

      // Hardcoded image URL
      Items item = Items(
        name: name,
        price: price,
        descritpion: description,
        productId: productId,
        imageUrl:
            "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bW9iaWxlJTIwYXBwfGVufDB8fDB8fHww",
      );

      await firestore.collection("products").doc(productId).set(item.toJson());

      Get.snackbar("Success", "Product Uploaded Successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(() => BottomNavBar()); // or Get.to(() => BottomNavBar());
    } catch (e) {
      debugPrint("Error uploading data: $e");
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
