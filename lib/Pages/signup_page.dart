import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/Utils/loadingScreen.dart';
import 'package:minorityreport/ViewModel/locationService.dart';
import 'package:minorityreport/data_for_log_register/auth.dart';

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
  final AuthService _auth = AuthService();
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
      String _returnString = await _auth.signUpUser(
          email, password, displayName, phoneNumber, photoUrl, geoPoints);

      if (_returnString == "success") {
        Navigator.pushReplacementNamed(context, "/loginpage");
      } else {}
    } catch (error) {
      print(error.toString());
      return null;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loadingScreen()));
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
        radius: 48.0,
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
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final phoneNo = TextFormField(
      autofocus: false,
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: 'Phone',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          if (_emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty &&
              _displayNameController.text.isNotEmpty) {
            print(
                "Values: " + _emailController.text + _passwordController.text);
            _signUpUser(_emailController.text, _passwordController.text,
                context, _displayNameController.text, _phoneController.text);
          } else {
            await showMyDialog(
                context, "FillOut Error", "All Fields are Naccessory");
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Register', style: TextStyle(color: Colors.white)),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
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
            forgotLabel
          ],
        ),
      ),
    );
  }
}
