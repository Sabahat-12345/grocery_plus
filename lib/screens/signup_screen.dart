import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor ?? Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Logo
                Image.asset("images/splash_image.png", height: 100),

                const SizedBox(height: 20),

                // Welcome Text
                Text("Create Account",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)),
                const SizedBox(height: 10),
                Text("Start your grocery journey with us!",
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: AppColors.fontGrayColor)),

                const SizedBox(height: 30),

                // Name Input
                CustomTextField(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
                  controller: nameController,
                ),
                const SizedBox(height: 15),

                // Email Input
                CustomTextField(
                  hintText: "Email Address",
                  prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // Password Input
                CustomTextField(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                  suffixIcon: Icon(Icons.visibility_off),
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 30),

                // SignUp Button
                PrimaryButton(
                  title: "Sign Up",
                  icon: Icons.check,
                  ontap: () {
                    // Navigate to home or login
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Account Created!"),
                    ));
                  },
                ),
                const SizedBox(height: 20),

                // SignIn Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: AppColors.fontGrayColor)),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const LoginScreen()));
                      },
                      child: Text("Login",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
