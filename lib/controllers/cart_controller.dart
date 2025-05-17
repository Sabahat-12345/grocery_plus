import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/grocery_model.dart';

class CartController extends GetxController {
  var cartItems = <Items>[].obs;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  void fetchCartItems() {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("cartItems")
        .snapshots()
        .listen((snapshot) {
      cartItems.value =
          snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList();
    });
  }

  Future<void> deleteCartItem(String productId) async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(productId)
          .delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
