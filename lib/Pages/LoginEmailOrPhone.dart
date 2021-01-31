import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/PhoneLogin.dart';
import 'package:minorityreport/Pages/signup_page.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:minorityreport/ViewModel/locationService.dart';
import 'package:minorityreport/controller/AuthController.dart';

import 'login_page.dart';

class LoginemailorPhone extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginemailorPhoneState createState() => new _LoginemailorPhoneState();
}

class _LoginemailorPhoneState extends State<LoginemailorPhone> {
  locationService location = new locationService();
  Position position;
  //Controller
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

//final action
  final _auth = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _showPassword = true;

  String email, password, photoUrl, geoPoints;

  //

  //signUpUser
  void _signUpUser(String email, String password, BuildContext context,
      String displayName, String phoneNumber) async {
    position = await location.getlastPosition();
    geoPoints =
        "" + position.latitude.toString() + " " + position.longitude.toString();
    try {
      Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
      String _returnString = await _auth.signUpUser(
          email, password, displayName, phoneNumber, photoUrl, geoPoints);

      if (_returnString == "success") {
        Get.back();
        Get.offAllNamed("/loginpage");
      } else {}
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  String passError = null;
  checkPass(String pass1, String pass2) {
    if (pass1 == pass2) {
      passError = null;
      setState(() {});
      return true;
    } else {
      passError = 'password does not match';
      setState(() {});
      return false;
    }
  }

  @override
  void setState(fn) async {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 120.0,
        child: Image.asset('lib/assets/logo.png'),
      ),
    );
    final loginButton2 = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Get.to(PhoneLogin(title: "PhoneAuth"));
      },
      padding: EdgeInsets.all(12),
      color: Colors.blue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone_android_outlined),
          Text('    Rigister with Phone',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    final login2Email = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Get.to(SignupPage());
      },
      padding: EdgeInsets.all(12),
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone_android_outlined),
          Text('    Rigister with Email',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            login2Email,
            SizedBox(height: 10.0),
            loginButton2,
          ],
        ),
      ),
    );
  }
}
