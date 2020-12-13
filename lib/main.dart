import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Pages/DetailEnter.dart';
import 'Pages/First_Page.dart';
import 'Pages/ListPage.dart';
import 'Pages/login_page.dart';
import 'Pages/signup_page.dart';
import 'ViewModel/loadinWidget.dart';
import 'controller/AuthController.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: 'Minority Report', home: MyApp(), // initialRoute: '/homepage',
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/homepage': (BuildContext context) => new FirstPage(),
        '/loginpage': (BuildContext context) => new LoginPage(),
        '/list': (BuildContext context) => new RatingList(),
        '/Register': (BuildContext context) => new SignupPage(),
        '/AddList': (BuildContext context) => new DetailEntry()
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error Processing');
        }
        if (snapshot.hasData) {
          return snapshot.data;
        }
        return LoadingWidget();
      },

///////////////////////////////////////////
    );
  }
}
