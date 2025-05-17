import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../controllers/profile_controller.dart';
import '../screens/change_password_sceen.dart';
import '../screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());

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
        child: Obx(() {
          final user = controller.currentUser.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user?.profilePic ?? ""),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  user?.username ?? "Sabahat Ali",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  user?.email ?? "sabahatali976@gmail.com",
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: AppColors.fontGrayColor),
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1.5,
              ),
              const SizedBox(height: 20),
              _buildProfileOption('Edit Profile', Icons.edit, onTap: () {
                Get.to(() => EditProfileScreen(currentUser: user!));
              }),
              _buildProfileOption('Order History', Icons.history),
              _buildProfileOption('Payment Methods', Icons.payment),
              _buildProfileOption('Addresses', Icons.location_on),
              _buildProfileOption('Change Password', Icons.lock, onTap: () {
                Get.to(() => const ChangePasswordSceen());
              }),
              _buildProfileOption('Log Out', Icons.logout, onTap: () {
                controller.logout();
              }),
            ],
          );
        }),
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
