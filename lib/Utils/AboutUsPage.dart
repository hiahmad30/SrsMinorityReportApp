import 'Consts.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static String tag = 'AboutUsPage';

  @override
  Widget build(BuildContext context) {
    final policyH = Padding(
      padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          'About Us',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            '      Minority Reports is a black owned Bussiness locator. Our Application features over 2000+ black owned cafes, diners,Police Stations, and restaurants nationwide. Now its easy to find soul food, Bussiness, Police Officer , and African eateries in any place.\n',
            style: TextStyle(color: MyColors.listp1Font, fontSize: 16),
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            'Contact info:',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(Icons.person),
              Text(
                '  K. Ivey ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.map_rounded),
              Text(
                '  PO Box 18761 Jacksonville,\n Fl 32229',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.email_rounded),
              Text(
                '  minorityreports2020@gmail.com',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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
