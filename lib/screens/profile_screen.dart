import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/Models/user_model.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/screens/change_password_sceen.dart';
import 'package:grocery_plus/screens/edit_profile_screen.dart';
import 'package:grocery_plus/screens/login_screen.dart';
import 'package:grocery_plus/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  UserModel? currentUser;
  Future<void> logout() async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (c) => LoginScreen()), (route) => false);
    } on FirebaseAuthException catch (e) {
      debugPrint("this is the error${e.code}");
    }
  }

  Future<void> fetchCurrentUserData() async {
    try {
      var userData =
          await firestore.collection("Users").doc(auth.currentUser!.uid).get();
      if (userData.exists) {
        setState(() {
          currentUser = UserModel.fromMap(userData.data()!);
        });
      } else {
        debugPrint("User data does not exist");
      }
    } catch (e) {
      debugPrint("this is the error$e");
    }
  }

  @override
  void initState() {
    fetchCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(currentUser?.profilePic ?? ""),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                currentUser?.username ?? "Sabahat Ali",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                currentUser?.email ?? "sabahatali976@gmail.com",
                style: GoogleFonts.poppins(
                    fontSize: 16, color: AppColors.fontGrayColor),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildProfileOption('Edit Profile', Icons.edit, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    currentUser: currentUser!,
                  ),
                ),
              );
            }),
            _buildProfileOption('Order History', Icons.history),
            _buildProfileOption('Payment Methods', Icons.payment),
            _buildProfileOption('Addresses', Icons.location_on),
            _buildProfileOption('Change Password', Icons.lock, onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const ChangePasswordSceen()));
            }),
            _buildProfileOption('Log Out', Icons.logout, onTap: () {
              logout();
              // Implement log out logic
              setState(() {
                // Update state if needed
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primaryColor),
          title: Text(
            title,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing:
              Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
