import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/Models/grocery_model.dart';
import 'package:grocery_plus/constants/groccery_item.dart';
import 'package:grocery_plus/controllers/home_controller.dart';
import 'package:grocery_plus/screens/product_detail.dart';
import 'package:grocery_plus/screens/upload_items.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/home_card_widget.dart';
import 'package:grocery_plus/widgets/home_shimmer_widget.dart';
import 'package:grocery_plus/widgets/location_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();
  var homeController = Get.put(HomeController());
  // var firestore = FirebaseFirestore.instance;
  // bool isloading = false;
  // List<Items> itemslist = [];
  // GrocceryItem item = GrocceryItem();

  // void fetchData() async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   try {
  //     var snapshot = await firestore.collection("products").get();
  //     itemslist =
  //         snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList();
  //     setState(() {
  //       isloading = false;
  //     });
  //   } catch (e) {
  //     debugPrint("Error while fetching data: $e");
  //   }
  // }

  // @override
  // void initState() {
  //   fetchData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => UploadItems()));
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Grocery Plus",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.notifications_outlined)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LocationWidget(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // CustomTextField(
                //     hintText: "Search here",
                //     prefixIcon: Icon(Icons.search),
                //     controller: searchController),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: "Search here",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 12,
                ),
                Obx(() {
                  if (homeController.isloading.value) {
                    return Expanded(
                      child: GridView.builder(
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return HomeShimmerWidget();
                          }),
                    );
                  } else if (homeController.itemsList.isEmpty) {
                    return const Center(
                      child: Text("No Products To Show"),
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: homeController.itemsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return HomeCardWidget(
                            image: homeController.itemsList[index].imageUrl,
                            name: homeController.itemsList[index].name,
                            rating: "0",
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => ProductDetailScreen(
                                    items: homeController.itemsList[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        ));
  }
}
