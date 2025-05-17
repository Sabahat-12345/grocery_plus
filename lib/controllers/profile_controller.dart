import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Models/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    fetchCurrentUserData();
    super.onInit();
  }

  Future<void> fetchCurrentUserData() async {
    try {
      var userData =
          await firestore.collection("Users").doc(auth.currentUser!.uid).get();
      if (userData.exists) {
        currentUser.value = UserModel.fromMap(userData.data()!);
      } else {
        Get.snackbar("Error", "User data does not exist");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString());
    }
  }
}
