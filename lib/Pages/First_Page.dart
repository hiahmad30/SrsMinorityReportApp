import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'ListPage.dart';
import 'login_page.dart';
import 'signup_page.dart';

final List<String> imgList = [
  'lib/assets/1.jpg',
  'lib/assets/4.jpg',
  'lib/assets/3.jpg',
  'lib/assets/2.jpg',
];

class FirstPage extends StatelessWidget {
  static String tag = 'FirstPage';
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          // child: Text(
                          //   'No. ${imgList.indexOf(item)} image',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome to Minority Report"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: MyColors.backGroundGradient,
          ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: MyColors.PrimaryColor,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    ),
                    items: imageSliders,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              MyButtons.myButton("Search Form", context, RatingList()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              MyButtons.myButton("Register", context, SignupPage()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              MyButtons.myButton("Login", context, LoginPage()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              MyButtons.myButton("Anonymous", context, LoginPage()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              //   SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.01,
              //   ),
              //  // MyButtons.myButton("Imei", context, ImeiPage()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyButtons.footer(context),
    );
  }
}
