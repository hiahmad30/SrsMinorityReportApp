import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/ListPage.dart';
import 'package:minorityreport/Pages/PhoneLogin.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:minorityreport/ViewModel/locationService.dart';
import 'package:minorityreport/controller/AuthController.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

    try {
      Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
      String _returnString = await _auth.signUpUser(
          email, password, displayName, phoneNumber, photoUrl, geoPoints);

      if (_returnString == "success") {
        {
          Get.back();
          Get.back();
          Get.back();
          //  Get.offAll(() => RatingList());
        }
      } else {
        await FirebaseAuth.instance.currentUser.delete();
        //   Get.back();
      }
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
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 120.0,
        child: Image.asset('lib/assets/logo.png'),
      ),
    );
    final displayName = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _displayNameController,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: _showPassword,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: _showPassword,
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        errorText: passError,
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final phoneNo = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: 'Phone',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _displayNameController.text.isNotEmpty) {
          if (checkPass(
              _passwordController.text, _confirmPasswordController.text)) {
            _signUpUser(_emailController.text, _passwordController.text,
                context, _displayNameController.text, _phoneController.text);
          } else {
            Get.snackbar("Password error", "Password does not macth");
          }
        } else {
          Get.snackbar('Fill all fields', "All Fields are Naccessory");
        }
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Text('Register', style: TextStyle(color: Colors.white)),
    );
    final loginButton2 = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Get.to(PhoneLogin(title: "Sign in with Phone"));
      },
      padding: EdgeInsets.all(12),
      color: Colors.blue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone_android_outlined),
          Text('    Or Rigister with Phone',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Do you have accout?"),
        FlatButton(
          child: Text(
            'Sign in',
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          onPressed: () {
            Get.to(LoginPage());
          },
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            displayName,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            confirmPassword,
            SizedBox(height: 8.0),
            phoneNo,
            SizedBox(height: 24.0),
            loginButton,
            // SizedBox(height: 8.0),
            // loginButton2,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
