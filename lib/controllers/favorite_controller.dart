import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/grocery_model.dart';

class FavoriteController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var favoriteItems = <Items>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  void fetchFavorites() {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("wishList")
        .snapshots()
        .listen((snapshot) {
      favoriteItems.value =
          snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList();
    });
  }

  Future<void> deleteWishListItem(String productId) async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(productId)
          .delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
