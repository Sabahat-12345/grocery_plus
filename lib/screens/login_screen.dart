import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/screens/bottom_Nav_bar.dart';
import 'package:grocery_plus/screens/forget_password_screen.dart';
import 'package:grocery_plus/screens/signup_screen.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Set background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding around the screen
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/splash_image.png", // Splash image at the top
                  height: 120,
                  width: 220,
                ),
                const SizedBox(height: 30),

                // Welcome Text
                Text("Welcome to",
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.fontColor)),
                Text("Grocery Plus",
                    style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)),
                const SizedBox(height: 10),

                // Subtext
                Text("Please login to your account!",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fontGrayColor)),
                const SizedBox(height: 30),

                // Email Input Field
                CustomTextField(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail, color: AppColors.primaryColor),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Password Input Field
                CustomTextField(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                  controller: passwordController,
                  suffixIcon: Icon(Icons.visibility_off),
                  obscureText: true, // Secure password input
                ),
                const SizedBox(height: 10),

                // Forgot Password Link
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const ForgetPasswordScreen()));
                    },
                    child: Text("Forgot Password?",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor)),
                  ),
                ),

                const SizedBox(height: 40),

                // Next Button
                PrimaryButton(
                  title: "Next",
                  icon: Icons.arrow_forward,
                  ontap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (c) => BottomNavBar()),
                        (route) => false);
                  },
                ),
                const SizedBox(height: 20),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: AppColors.fontGrayColor)),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => SignUpScreen()));
                      },
                      child: Text("Sign Up",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
