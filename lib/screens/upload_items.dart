import 'package:flutter/material.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class UploadItems extends StatefulWidget {
  const UploadItems({super.key});

  @override
  State<UploadItems> createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  var nameController = TextEditingController();
  var idController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  border: Border.all(color: AppColors.fontColor, width: 1),
                ),
                child: Center(
                  child: Icon(Icons.add_a_photo),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: "Enter Product Name", controller: nameController),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                hintText: "Enter Product description",
                controller: idController,
                maxLines: 4,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                  hintText: "Enter Product price", controller: priceController),
              const SizedBox(height: 50),
              PrimaryButton(title: "Upload", ontap: () {})
            ],
          ),
        ),
      )),
    );
  }
}
