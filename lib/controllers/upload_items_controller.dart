import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/Models/grocery_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class UploadItemsController extends GetxController {
  var imageFile=Rxn<XFile>();
  final ImagePicker picker = ImagePicker();
  var firestore = FirebaseFirestore.instance;
  Future<void> pickImage() async {
    try {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.camera);
    if(selectedImage!=null){
      imageFile.value=selectedImage;
    }
    } catch (e) {
      debugPrint("Error while picking image: $e");
    }
  }

  void uploadData(String name,String price,String discription) async {
    // setState(() {
    //   isLoading = true;
    // });
    try {
      // var imageUrl = uploadImageToFirebaseStorage(imageFile!);
      var productId = Uuid().v1();
      Items items = Items(
          name: name,
          imageUrl:
              "https://e7.pngegg.com/pngimages/354/144/png-clipart-cheeseburger-buffalo-burger-breakfast-sandwich-hamburger-slider-cheese-food-cheese-thumbnail.png",
          descritpion: discription,
          price: price,
          productId: productId);
      await firestore.collection("products").doc(productId).set(items.toJson());
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => BottomNavBar(),
      //     ));
    } catch (e) {
      debugPrint("Error while uploading data: $e");
    } finally {
      
    }
  }
}
