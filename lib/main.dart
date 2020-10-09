
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'Pages/DetailEnter.dart';
import 'Pages/First_Page.dart';
import 'Pages/ListPage.dart';
import 'Pages/login_page.dart';
import 'Pages/signup_page.dart';
import 'Utils/Consts.dart';

void main() async {
   //Auth _auth=new Auth();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // } catch (e) {
  //   print("Baba g" + e.toString());
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minority Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/list',
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/homepage': (BuildContext context) => new FirstPage(),
        '/loginpage': (BuildContext context) => new LoginPage(),
        '/list': (BuildContext context) => new RatingList(),
        '/Register': (BuildContext context) => new SignupPage(),
        '/AddList': (BuildContext context) => new DetailEntry()
      },
    );
  }
}
