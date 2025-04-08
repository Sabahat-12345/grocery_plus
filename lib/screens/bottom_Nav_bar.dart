import 'package:flutter/material.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/screens/favorite_screen.dart';
import 'package:grocery_plus/screens/home_screen.dart';
import 'package:grocery_plus/screens/profile_screen.dart';

import 'card_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0; // Declare and initialize selectedIndex
  List Screens = [
    HomeScreen(),
    CardScreen(),
    FavoriteScreen(),
    ProfileScreen(),
   
  ]; // List of screens to display

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index; // Update selectedIndex on tap
          });
        },
         type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.fontColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Card'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: Screens[selectedIndex],
    );
  }
}