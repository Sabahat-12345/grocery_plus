import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/controllers/change_password_controller.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.emailController,
                        decoration: _inputDecoration("Enter Your Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.passwordController,
                        decoration: _inputDecoration("Enter Your Old Password"),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.newPasswordController,
                        decoration: _inputDecoration("Enter Your New Password"),
                        obscureText: true,
                      ),
                      const SizedBox(height: 300),
                      PrimaryButton(
                        title: "Update",
                        ontap: controller.changePassword,
                      ),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
