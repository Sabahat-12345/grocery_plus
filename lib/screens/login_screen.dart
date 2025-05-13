import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/controllers/auth_controller.dart';
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
  bool isLoading = false;
  String? name;
  AuthController authController = Get.put(AuthController());
  // FirebaseAuth auth = FirebaseAuth.instance;

  // Future<void> loginUser() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please fill all the fields')),
  //       );
  //       return;
  //     }

  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     if (userCredential.user != null && userCredential.user!.emailVerified) {
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (c) => BottomNavBar()),
  //         (route) => false,
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('User is not verified or does not exist')),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.message ?? 'Login failed')),
  //     );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // bool isShow = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/splash_image.png",
                        height: 120,
                        width: 220,
                      ),
                      const SizedBox(height: 30),
                      Text("Welcome to ",
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
                      Text("Please login to your account!",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fontGrayColor)),
                      const SizedBox(height: 30),

                      // Email Field
                      CustomTextField(
                        hintText: "Email",
                        prefixIcon:
                            Icon(Icons.mail, color: AppColors.primaryColor),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        hintText: "Password",
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.primaryColor),
                        controller: passwordController,
                        // suffixIcon: Icon(Icons.visibility_off),
                        // obscureText: isShow,
                        onTap: () {
                          // setState(() {
                          //     isShow = !isShow;
                          //   }  );
                          authController.isShow.value =
                              !authController.isShow.value;
                        },
                        suffixIcon: Icon(
                          Icons.visibility_off,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const ForgetPasswordScreen()),
                            );
                          },
                          child: Text("Forgot Password?",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryColor)),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Login Button
                      PrimaryButton(
                        title: "Next",
                        icon: Icons.arrow_forward,
                        ontap: () {
                          authController.loginUser(
                              emailController.text, passwordController.text);
                        },
                      ),

                      const SizedBox(height: 20),

                      // Sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColors.fontGrayColor)),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SignUpScreen()),
                              );
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
