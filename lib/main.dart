import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Pages/First_Page.dart';

import 'ViewModel/loadinWidget.dart';
import 'controller/AuthController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: 'Minority Report', home: MyApp(), // initialRoute: '/homepage',
    ),
  );
}

class MyApp extends StatelessWidget {
  // final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FirstPage();
//     FutureBuilder(
//       future: authController.checkUserLoggedIn(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error Processing');
//         }
//         if (snapshot.hasData) {
//           return snapshot.data;
//         }
//         return LoadingWidget();
//       },

// ///////////////////////////////////////////
//     );
  }
}
