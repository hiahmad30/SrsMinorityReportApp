import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/Utils/loadingScreen.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

//  String okMsg;
  bool _showPassword = true, isSignedIn = false;
  String okMsg;
  bool isload = false;
  /////////////////
  ///

  Future<void> _showMyDialog(String a) async {
    // return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Authentication Error'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text(''),
    //               Text(a),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text('ok'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     });
    Get.snackbar("Logon Error", a.toString());
  }

  ///

  void signIn(String email, String password) async {
    User user;
    String errorMessage;
    FirebaseAuth _auth = FirebaseAuth.instance;
    isSignedIn = true;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      u_id = user.uid;
    } catch (error) {
      // Alert(
      //   context: context,
      //   title: "SignIn Error",
      // );
      switch (error.toString()) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          _showMyDialog(
              "Your email address appears to be not in correct form.");
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          _showMyDialog("Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          _showMyDialog("User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          _showMyDialog("User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          _showMyDialog("Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          _showMyDialog("Signing in with Email and Password is not enabled.");
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    if (u_id != null) {
      isSignedIn = false;

      Get.toNamed("/list");
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => loadingScreen()),
          (route) => false);
    }
  }

  @override
  void initState() {
    // autoSign();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
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

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      //autovalidate: true,
      onChanged: (value) => {},
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      //  autovalidate: true,
      autofocus: false,
      obscureText: _showPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _pass,
      onChanged: (value) => {},
    );

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          padding: EdgeInsets.all(12),
          color: MyColors.PrimaryColor,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            signIn(_email.text, _pass.text);
          },
        ));
    final signupLbl = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("or"),
        FlatButton(
          child: isSignedIn
              ? LoadingWidget()
              : Text(
                  'Register',
                  style: TextStyle(color: MyColors.PrimaryColor),
                ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignupPage()));
          },
        ),
      ],
    ));
    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
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
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            signupLbl
          ],
        ),
      ),
    );
  }

  Widget errorWidgett(String s) {
    return AlertDialog(
      title: Text("Alert Dialog"),
      content: Text("$s"),
      actions: [
        FlatButton(
          child: Text("Close"),
          onPressed: () => Navigator.canPop(context),
        )
      ],
    );
  }
}
