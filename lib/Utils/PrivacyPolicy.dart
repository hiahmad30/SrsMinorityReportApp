import 'package:flutter/material.dart';
import 'package:minorityreport/Utils/Consts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static String tag = 'PrivacyPolicyPage';

  @override
  Widget build(BuildContext context) {
    final policyH = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Privacy Policy',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        PrivacyPolicy,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final body = SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ]),
        ),
        child: Column(
          children: <Widget>[policyH, lorem],
        ),
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
