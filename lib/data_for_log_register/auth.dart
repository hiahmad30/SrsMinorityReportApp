import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'database.dart';
import 'users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
    String email,
    String password,
    String displayName,
    String phoneNumber,
    String photo,
    String geoPoint,
  ) async {
    String retVal = "error";

    try {
      // await _auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: , verificationFailed: null, codeSent: null, codeAutoRetrievalTimeout: null)
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      updatePhone(phoneNumber);
      UserModel _user = UserModel(
          uid: _authResult.user.uid,
          email: _authResult.user.email,
          displayName: displayName,
          phoneNumber: phoneNumber,
          photoUrl: null,
          accountCreated: Timestamp.now(),
          geoPoints: geoPoint);
      String _returnString = await DatabaseService().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (error) {
      print(error.toString());
      return null;
    }
    return retVal;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String e, String p) async {
    final UserCredential user =
        (await _firebaseAuth.signInWithEmailAndPassword(email: e, password: p));
    return user?.user.uid;
  }

  Future<void> currentUserLoggedIn() {
    u_id = _auth.currentUser.uid;
  }
  // Future<bool> signInWithEmail(String em, String ps) async {
  //   UserCredential re =
  //       await _firebaseAuth.signInWithEmailAndPassword(email: em, password: ps);
  //   if (re.user != null) {
  //     u_id = re.user.uid;
  //     return true;
  //   } else
  //     return false;
  // }

  // String phoneNo;
  // String smsOTP;
  // String verificationId;
  // String errorMessage = '';
  //////////////////////////////////////////////////////
  updatePhone(String ph) {
    _auth.verifyPhoneNumber(
        phoneNumber: ph,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          await _auth.currentUser.updatePhoneNumber(credential);
          // either this occurs or the user needs to manually enter the SMS code
        },
        verificationFailed: null,
        codeSent: (verificationId, [forceResendingToken]) async {
          String smsCode;
          // get the SMS code from the user somehow (probably using a text field)
          final AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await _auth.currentUser.updatePhoneNumber(credential);
        },
        codeAutoRetrievalTimeout: null);
  }

////////////////////////////////////////////////////////////////
  // void verifyPhone(
  //   BuildContext context,
  // ) async {
  //   final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
  //     this.verificationId = verId;
  //     smsOTPDialog(context).then((value) {
  //       print('sign in');
  //     });
  //   };
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
  //         codeAutoRetrievalTimeout: (String verId) {
  //           //Starts the phone number verification process for the given phone number.
  //           //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
  //           this.verificationId = verId;
  //         },
  //         codeSent:
  //             smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
  //         timeout: const Duration(seconds: 20),
  //         verificationCompleted: (AuthCredential phoneAuthCredential) {
  //           print(phoneAuthCredential);
  //         },
  //         verificationFailed: (exceptio) {
  //           print('${exceptio.message}');
  //         });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<bool> smsOTPDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           title: Text('Enter SMS Code'),
  //           content: Container(
  //             height: 85,
  //             child: Column(children: [
  //               TextField(
  //                 onChanged: (value) {
  //                   this.smsOTP = value;
  //                 },
  //               ),
  //               (errorMessage != ''
  //                   ? Text(
  //                       errorMessage,
  //                       style: TextStyle(color: Colors.red),
  //                     )
  //                   : Container())
  //             ]),
  //           ),
  //           contentPadding: EdgeInsets.all(10),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('Done'),
  //               onPressed: () {
  //                 // _auth.currentUser().then((user) {
  //                 //   if (user != null) {
  //                 //     Navigator.of(context).pop();
  //                 //     Navigator.of(context).pushReplacementNamed('/homepage');
  //                 //   } else {}
  //                 // });
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  // signIn() async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.getCredential(
  //       verificationId: verificationId,
  //       smsCode: smsOTP,
  //     );
  //     final UserCredential user = await _auth.signInWithCredential(credential);
  //     final FirebaseUser currentUser = await _auth.currentUser();
  //     assert(user.uid == currentUser.uid);
  //     Navigator.of(context).pop();
  //     Navigator.of(context).pushReplacementNamed('/homepage');
  //   } catch (e) {
  //     handleError(e);
  //   }
  // }

  // handleError(PlatformException error) {
  //   print(error);
  //   switch (error.code) {
  //     case 'ERROR_INVALID_VERIFICATION_CODE':
  //       FocusScope.of(context).requestFocus(new FocusNode());
  //       setState(() {
  //         errorMessage = 'Invalid Code';
  //       });
  //       Navigator.of(context).pop();
  //       smsOTPDialog(context).then((value) {
  //         print('sign in');
  //       });
  //       break;
  //     default:
  //       setState(() {
  //         errorMessage = error.message;
  //       });

  //       break;
  //   }
  // }
}
