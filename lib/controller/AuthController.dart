import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/First_Page.dart';
import 'package:minorityreport/Pages/ListPage.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';

class AuthController extends GetxController {
  // Intilize the flutter app
  FirebaseApp firebaseApp;
  User firebaseUser;
  FirebaseAuth firebaseAuth;

  Future<void> initlizeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
  }

  Future<Widget> checkUserLoggedIn() async {
    if (firebaseApp == null) {
      await initlizeFirebaseApp();
    }
    if (firebaseAuth == null) {
      firebaseAuth = FirebaseAuth.instance;
      update();
    }
    if (firebaseAuth.currentUser == null) {
      return FirstPage();
    } else {
      firebaseUser = firebaseAuth.currentUser;
      u_id = firebaseUser.uid;
      update();
      return FirstPage();
    }
  }

  ////////////////////////////////////////////////////////////Auth with email////////////////////////
  Future<void> signInwithEmail(String emails, String passs) async {
    try {
      Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
      print(emails);
      firebaseAuth = FirebaseAuth.instance;

      final userCredentialData = await firebaseAuth.signInWithEmailAndPassword(
          email: emails, password: passs);
      firebaseUser = userCredentialData.user;
      u_id = firebaseUser.uid;
      update();
      Get.back();
      Get.to(RatingList());
    } catch (ex) {
      print(ex.toString());
      Get.back();
      Get.snackbar('Sign In Error', 'Error Signing in with email and password',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }

  void createUser(
      String name, String email, String password, String phone) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Admins");
      Map<String, String> userdata = {
        "Name": name,
        "CreatedAt": DateTime.now().toLocal().toString(),
        "Email": email,
        "Phone": phone
      };

      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        reference
            .doc(value.user.uid)
            .set(userdata)
            .then((value) => Get.offAll(RatingList()));
      }).catchError(
        (onError) =>
            Get.snackbar("Error while creating account ", onError.message),
      );
      update();
    } catch (err) {
      Get.back();
      Get.snackbar("Error while creating account ", err.message);
    }
  }
}
