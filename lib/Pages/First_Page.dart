import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minorityreport/Utils/Consts.dart';

final List<String> imgList = [
  'lib/assets/1.jpg',
  'lib/assets/4.jpg',
  'lib/assets/3.jpg',
  'lib/assets/2.jpg',
];

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ), // width: 1000.0),
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome to Minority Report",
            style: GoogleFonts.aclonica(fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            )
          ],
          backgroundColor: MyColors.PrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    height: MediaQuery.of(context).size.height * 0.3,
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

                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Categories",
                            style: GoogleFonts.ubuntu(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //  Image.asset(
                                  //    'lib/assets/police.png',
                                  //     width: 80,
                                  //   ),
                                  Text(
                                    'Police officers',
                                    style: GoogleFonts.amiko(),
                                  )
                                ],
                              ),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(
                                  0xffc5e3f6,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffba53de),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(
                                  0xff5be7c4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                              height: 150,
                              width: 150,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffcabbe9),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff30e3ca),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                              height: 150,
                              width: 150,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xfff8d0b0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,

                                      // spreadRadius: 1,

                                      blurRadius: 5),
                                ],
                              ),
                              height: 150,
                              width: 150,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox(

                //   height: MediaQuery.of(context).size.height * 0.1,

                // ),

                // MyButtons.myButton("Search Form", context, RatingList()),

                // SizedBox(

                //   height: MediaQuery.of(context).size.height * 0.01,

                // ),

                // MyButtons.myButton("Register", context, SignupPage()),

                // SizedBox(

                //   height: MediaQuery.of(context).size.height * 0.01,

                // ),

                // MyButtons.myButton("Login", context, LoginPage()),

                // SizedBox(

                //   height: MediaQuery.of(context).size.height * 0.01,

                // ),

                // MyButtons.myButton("Anonymous", context, LoginPage()),

                // SizedBox(

                //   height: MediaQuery.of(context).size.height * 0.01,

                // ),

                //   SizedBox(

                //     height: MediaQuery.of(context).size.height * 0.01,

                //   ),

                //  // MyButtons.myButton("Imei", context, ImeiPage()),
              ]),
        ));
  }
}
