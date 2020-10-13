import 'Consts.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static String tag = 'AboutUsPage';

  @override
  Widget build(BuildContext context) {
    final policyH = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'About Us',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Contact info:',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Text('K. Ivey PO Box 18761 Jacksonville, Fl 32229'),
        ],
      ),
    );

    final body = SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
    ));

    return Scaffold(
      body: body,
    );
  }
}
