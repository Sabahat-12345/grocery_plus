import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  var auth = FirebaseAuth.instance;
  sendlinkForResetPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Enter Your Email")));
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password Reset Link Sent Successfully")));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      debugPrint("this is the error${e.code}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Forgot Password",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Logo or Banner
            Center(
              child: Image.asset(
                "images/splash_image.png",
                height: 120,
              ),
            ),
            const SizedBox(height: 30),

            // Text Instruction
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Reset your password",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter the email address associated with your account. We’ll send you a link to reset your password.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.fontGrayColor,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Card with input field
            Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Enter your email",
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.primaryColor,
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),

                  // Send Email Button
                  PrimaryButton(
                    title: "Send Reset Link",
                    icon: Icons.send,
                    ontap: () {
                      sendlinkForResetPassword();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
