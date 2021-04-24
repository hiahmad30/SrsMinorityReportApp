import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/First_Page.dart';

import 'Utils/Consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  runApp(
    GetMaterialApp(
      title: 'Minority Report', home: MyApp(), // initialRoute: '/homepage',
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    u_id = FirebaseAuth.instance.currentUser?.uid;
    return FirstPage();
  }
}
