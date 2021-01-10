import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/First_Page.dart';
import 'package:minorityreport/Pages/ListPage.dart';
import 'package:minorityreport/Pages/login_page.dart';
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

  void createUser(String name, String email, String password, String phone,
      String geo) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("users");
      Map<String, String> userdata = {
        "Name": name,
        "CreatedAt": DateTime.now().toLocal().toString(),
        "Email": email,
        "Phone": phone,
        'GeoLocation': geo
      };

     await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            value.user.linkWithPhoneNumber(phone);
        u_id = value.user.uid;
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
  /////////////////////////////////////////-------------------Phone verify-------------///////////////////////
  //  String phoneNumber, verificationId;
  // String otp, authStatus = "";

  // Future<void> verifyPhoneNumber(BuildContext context) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 15),
  //     verificationCompleted: (AuthCredential authCredential) {
  //       setState(() {
  //         authStatus = "Your account is successfully verified";
  //       });
  //     },
  //     verificationFailed: (AuthException authException) {
  //       setState(() {
  //         authStatus = "Authentication failed";
  //       });
  //     },
  //     codeSent: (String verId, [int forceCodeResent]) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "OTP has been successfully send";
  //       });
  //       otpDialogBox(context).then((value) {});
  //     },
  //     codeAutoRetrievalTimeout: (String verId) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "TIMEOUT";
  //       });
  //     },
  //   );
  // }

  // otpDialogBox(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           title: Text('Enter your OTP'),
  //           content: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: TextFormField(
  //               decoration: InputDecoration(
  //                 border: new OutlineInputBorder(
  //                   borderRadius: const BorderRadius.all(
  //                     const Radius.circular(30),
  //                   ),
  //                 ),
  //               ),
  //               onChanged: (value) {
  //                 otp = value;
  //               },
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.all(10.0),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 signIn(otp);
  //               },
  //               child: Text(
  //                 'Submit',
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // Future<void> signIn(String otp) async {
  //   await FirebaseAuth.instance
  //       .signInWithCredential(PhoneAuthProvider.getCredential(
  //     verificationId: verificationId,
  //     smsCode: otp,
  //   )).then((value) => {
  //     Get.to();
  //   });
  // }
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
