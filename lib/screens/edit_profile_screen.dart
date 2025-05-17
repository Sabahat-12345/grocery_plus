import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/Models/user_model.dart';
import 'package:grocery_plus/controllers/edit_profile_controller';

import 'package:grocery_plus/widgets/primary_button.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel currentUser;
  EditProfileScreen({super.key, required this.currentUser});

  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    controller.initUser(currentUser);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile picture section
                      Stack(
                        children: [
                          Obx(() => CircleAvatar(
                                radius: 60,
                                backgroundImage: controller.imageFile.value ==
                                        null
                                    ? NetworkImage(currentUser.profilePic ??
                                            "https://www.pngall.com/wp-content/uploads/5/Avatar-Profile-PNG-Clipart.png")
                                        as ImageProvider
                                    : FileImage(
                                        File(controller.imageFile.value!.path)),
                              )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: controller.pickImage,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(Icons.camera_alt_outlined,
                                    size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 👤 Username Field
                      TextField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 📧 Email Field
                      TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 📞 Phone Field
                      TextField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Phone',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 400),

                      // Save Button
                      PrimaryButton(
                        title: 'Save',
                        ontap: controller.updateUserProfile,
                      ),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
