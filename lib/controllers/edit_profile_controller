// controllers/edit_profile_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_plus/Models/user_model.dart';
import 'package:grocery_plus/upload_image.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  final isLoading = false.obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);
  late UserModel currentUser;

  void initUser(UserModel user) {
    currentUser = user;
    nameController = TextEditingController(text: user.username);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
  }

  Future<void> pickImage() async {
    try {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.camera);
      imageFile.value = selectedImage;
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  Future<void> updateUserProfile() async {
    try {
      isLoading.value = true;
      String imageUrl = currentUser.profilePic ?? "";

      if (imageFile.value != null) {
        imageUrl = await uploadImageToFirebaseStorage(imageFile.value!);
      }

      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'username': nameController.text,
        'profilePic': imageUrl,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      isLoading.value = false;
      Get.snackbar("Success", "Profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed('/home'); // or Get.to(BottomNavBar());
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
