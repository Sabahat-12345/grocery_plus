import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_plus/Models/user_model.dart';
import 'package:grocery_plus/screens/bottom_Nav_bar.dart';
import 'package:grocery_plus/upload_image.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel currentUser;
  const EditProfileScreen({super.key, required this.currentUser});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  Future<void> pickImage() async {
    try {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = selectedImage;
      });
    } catch (e) {
      debugPrint("Error while picking image: $e");
    }
  }

  Future<void> updateUserProfile(
      String username, String userProfile, String email, String phone) async {
    try {
      setState(() {
        isLoading = true;
      });

      String imageUrl = widget.currentUser.profilePic ?? "";
      if (imageFile != null) {
        imageUrl = await uploadImageToFirebaseStorage(imageFile!);
      }

      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'username': username,
        'profilePic': imageUrl,
        'email': email,
        'phone': phone,
      });

      setState(() {
        isLoading = false;
      });

      // ✅ Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => BottomNavBar()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var nameController =
        TextEditingController(text: widget.currentUser.username);
    var emailController = TextEditingController(text: widget.currentUser.email);
    var phoneController = TextEditingController(text: widget.currentUser.phone);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      // ✅ Profile Image with camera icon bottom-right
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: imageFile == null
                                ? NetworkImage(widget.currentUser.profilePic ??
                                    "https://www.pngall.com/wp-content/uploads/5/Avatar-Profile-PNG-Clipart.png")
                                : FileImage(File(imageFile!.path))
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                pickImage();
                              },
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
                      CustomTextField(
                          hintText: 'Enter Name', controller: nameController),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: 'Enter Email', controller: emailController),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: 'Enter Phone', controller: phoneController),
                      const SizedBox(height: 400),
                      PrimaryButton(
                        title: 'Save',
                        ontap: () {
                          updateUserProfile(
                              nameController.text,
                              widget.currentUser.profilePic ?? '',
                              emailController.text,
                              phoneController.text);
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
