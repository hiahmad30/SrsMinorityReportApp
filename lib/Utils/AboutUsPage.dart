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
      child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
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
