import 'package:get/get.dart';

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
            '      Minority Report is a review application geared to AFRICAN-AMERICANS and other people of color to share their experiences at their favorite businesses and service providers. Our platform features restaurants, hotels, grocery stores, hospitals, doctors, Police Stations, Police Officers, and more worldwide. Now it is easy to find businesses that appreciate you, as well as identify those that are less friendly.\n',
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
              Icon(
                Icons.person,
                color: MyColors.listp1Font,
              ),
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
              Icon(
                Icons.map_rounded,
                color: MyColors.listp1Font,
              ),
              // Text(
              //   '  PO Box 18761 Jacksonville,\n Fl 32229',
              //   style: TextStyle(
              //     fontSize: 14.0,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.email_rounded,
                color: MyColors.listp1Font,
              ),
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
        width: Get.width,
        height: Get.height,
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
