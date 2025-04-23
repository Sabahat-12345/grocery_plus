import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var auth = FirebaseAuth.instance;
  Future<void> logout() async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (c) => LoginScreen()), (route) => false);
    } on FirebaseAuthException catch (e) {
      debugPrint("this is the error${e.code}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
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
                backgroundImage: AssetImage('images/my pic.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "Sabahat Ali",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "sabahat@email.com",
                style: GoogleFonts.poppins(
                    fontSize: 16, color: AppColors.fontGrayColor),
              ),
            ),
            const SizedBox(height: 30),
            _buildProfileOption('Edit Profile', Icons.edit),
            _buildProfileOption('Order History', Icons.history),
            _buildProfileOption('Payment Methods', Icons.payment),
            _buildProfileOption('Addresses', Icons.location_on),
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
