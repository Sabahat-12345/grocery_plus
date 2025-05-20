import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  var isLoading = false.obs;
  final auth = FirebaseAuth.instance;

  void changePassword() async {
    try {
      isLoading.value = true;
      User? user = auth.currentUser;

      if (user == null) {
        Get.snackbar("Error", "User not found",
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
        return;
      }

      var credential = EmailAuthProvider.credential(
        email: emailController.text,
        password: passwordController.text,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPasswordController.text);

      Get.snackbar("Success", "Password updated successfully",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      debugPrint("Error updating password: $e");
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
