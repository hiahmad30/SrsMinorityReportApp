
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Consts.dart';

class loadingScreen extends StatefulWidget {
  loadingScreen({Key key}) : super(key: key);

  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitCircle(
        color: MyColors.PrimaryColor,
        size: 50,
      ),
    );
  }
}
