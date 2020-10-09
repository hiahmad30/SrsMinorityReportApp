
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'AboutUsPage.dart';
import 'PrivacyPolicy.dart';
import 'Terms_and_Conditions.dart';

String u_id;
String testImageUrl = "https://www.gstatic.com/webp/gallery/3.webp";

bool isLogIn() {
  if (u_id == null)
    return false;
  else
    return true;
}

class MyColors {
  static final Color PrimaryColor = Colors.blue;
  static final Color SecColor = Colors.blue[50];

  static final Color listh1Font = Colors.white;
  static final Color listp1Font = Colors.white.withOpacity(0.6);

  static final Color h1FontBlack = Colors.black;
  static final Color p1FontBalck = Colors.black.withOpacity(0.6);
  static final LinearGradient backGroundGradient = LinearGradient(colors: [
    Colors.white,
    Colors.white,
  ]);
}

class MyButtons {
  static Widget footer(BuildContext context) {
    return BottomAppBar(
      color: MyColors.SecColor,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage()));
              },
              child: Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 12),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsandConditionPage()));
              },
              child: Text(
                "Terms & Conditions",
                style: TextStyle(fontSize: 12),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()));
              },
              child: Text(
                "About Us",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget myButton(String txt, BuildContext context, Widget a) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => a));
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Container(
          width: 300,
          child:
              Center(child: Text(txt, style: TextStyle(color: Colors.white)))),
    );
  }
}

Future<void> showMyDialog(
    BuildContext context, String title, String detail) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(detail),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String initPageRout;
String autoSign() {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // u_id = auth.currentUser.uid;
  if (u_id != "") {
    initPageRout = '/listPage';
    print("Ok hai sb");
  } else {
    initPageRout = '/loginpage';
  }
  return initPageRout;
}

const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);
