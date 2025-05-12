import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/controllers/product_controller.dart';
import '../Models/grocery_model.dart';
import '../constants/colors.dart';
import '../widgets/primary_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final Items items;
  ProductDetailScreen({super.key, required this.items});

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    controller.checkWishList(items.productId);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Product Detail"),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.fontColor, width: 1),
                      image: DecorationImage(
                          image: NetworkImage(items.imageUrl),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.inWishList.value) {
                                controller.removeFromWishList(items.productId);
                              } else {
                                controller.addToWishList(items);
                              }
                            },
                            child: Icon(
                              Icons.favorite,
                              color: controller.inWishList.value
                                  ? Colors.red
                                  : AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(items.price,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(items.descritpion,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => controller.addToCart(items),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.fontColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                              child: Icon(Icons.shopping_cart_checkout)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: PrimaryButton(title: "Buy Now", ontap: () {}))
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
