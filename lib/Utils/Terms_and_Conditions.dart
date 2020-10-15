import 'package:flutter/material.dart';

import 'Consts.dart';

class TermsandConditionPage extends StatelessWidget {
  static String tag = 'TermsanConditionPage';

  @override
  Widget build(BuildContext context) {
    final policyH = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Terms and Conditions',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        termConditionTxt,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final body = SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
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
    ));

    return Scaffold(
      body: body,
    );
  }
}
