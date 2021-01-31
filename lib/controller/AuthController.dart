import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/First_Page.dart';
import 'package:minorityreport/Pages/ListPage.dart';
import 'package:minorityreport/Pages/login_page.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:minorityreport/data_for_log_register/users.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'dbController.dart';

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
      Get.off(RatingList());
    } catch (ex) {
      print(ex.toString());
      Get.back();
      Get.snackbar('Sign In Error', 'Recheck your email and password',
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

  Future<String> signUpUser(
    String email,
    String password,
    String displayName,
    String phoneNumber,
    String photo,
    String geoPoint,
  ) async {
    String retVal = "error";
    final dbController = Get.put(DatabaseController());

    try {
      UserCredential _authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _authResult.user.updateProfile(
        displayName: displayName,
      );
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneCredential) async {
            String smsCode = 'xxxx';
            Get.back();
            // Create a PhoneAuthCredential with the code

            await _authResult.user.updatePhoneNumber(phoneCredential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');

              print(">>>>>>>>>>" + e.toString());
            }
          },
          codeSent: (String verificationId, int resendToken) async {
            String smsCode = 'xxxx';
            Get.back();
            await Get.defaultDialog(
                barrierDismissible: false,
                title: "Enter Code",
                content: Center(
                  child: OTPTextField(
                    length: 5,
                    width: Get.width,
                    fieldWidth: 80,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                      smsCode = pin;
                      Get.back();
                    },
                  ),
                ));
            // Create a PhoneAuthCredential with the code
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);
          },
          timeout: const Duration(minutes: 1),
          codeAutoRetrievalTimeout: (String verificationId) {});

      UserModel _user = UserModel(
          uid: _authResult.user.uid,
          email: _authResult.user.email,
          displayName: displayName,
          phoneNumber: phoneNumber,
          photoUrl: null,
          accountCreated: Timestamp.now(),
          geoPoints: geoPoint);
      String _returnString = await dbController.createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (error) {
      print("Error is of firebase" + error.toString());
      Get.back();
      Get.snackbar("Error", error.toString());

      return null;
    }
    return retVal;
  }

/////////////////////////////////////////-------------------Pass Reset-----------////////////////
  Future<void> sendpasswordresetemail1(String email) async {
    firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        Get.offAll(LoginPage());
        Get.snackbar("Password Reset email link is been sent", "Success");
      }).catchError(
          (onError) => Get.snackbar("Error In Email Reset", onError.message));
    } catch (e) {
      print("Error is: " + e.toString());
    }
  }

  signouUser() async {
    await firebaseAuth.signOut();
    u_id = null;
    update();
    Get.offAll(FirstPage());
  }
}
