import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:minorityreport/Utils/Consts.dart';

import 'DetailPage.dart';
import 'ListPage.dart';

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
  bool isload = false;
  TextStyle categoryFontStyle = GoogleFonts.adamina(fontSize: 20);
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
            style: GoogleFonts.aclonica(fontSize: 18),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Categories ",
                    style: GoogleFonts.ubuntu(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        _getCategoriy('Bars', 'lib/assets/bar.png', 'Bars'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy('Banks', 'lib/assets/Bank.png', 'Banks'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy(
                            'Car_Rentals', 'lib/assets/car.png', 'Car Rentals'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy('Clothing_Store', 'lib/assets/store.png',
                            'Clothing Stores'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy('FoodTrucks', 'lib/assets/foodTrucks.png',
                            'Food Trucks'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy(
                            'Hotels', 'lib/assets/hotel.png', 'Hotels'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy(
                            'Hospital', 'lib/assets/hospital.png', 'Hospitals'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy(
                            'Police', 'lib/assets/police.png', 'Police'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy(
                            'Public_Transportations',
                            'lib/assets/transportation.png',
                            'Public Transport'),
                        SizedBox(
                          width: 10,
                        ),
                        _getCategoriy('Resturant', 'lib/assets/resturant.png',
                            'Resturant'),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "List",
                        style: GoogleFonts.ubuntu(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon: Icon(Icons.more_horiz_outlined),
                          onPressed: () {
                            category = '';
                            Get.to(RatingList());
                          })
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("Bussiness List")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text('Loading.....');
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemExtent: 100,
                          itemBuilder: (context, index) => _CardList(
                              context, snapshot.data.documents[index]));
                    },
                  ),
                ),
              ]),
        ));
  }

  Widget _getCategoriy(
    String cat,
    String imageStr,
    String titleC,
  ) {
    return InkWell(
      onTap: () {
        category = cat;
        Get.to(RatingList());
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imageStr,
              width: 80,
            ),
            Text(
              titleC,
              style: GoogleFonts.amiko(),
            )
          ],
        ),
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(
            0xffc5e3f6,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,

                // spreadRadius: 1,

                blurRadius: 5),
          ],
        ),
      ),
    );
  }

  Widget _CardList(BuildContext context, DocumentSnapshot document) {
    var a = document.get("photoUrl");
    bool avail;
    if (a != null) {
      avail = true;
    } else {
      avail = false;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(15),

        //  color: const Color(0xff7c94b6),
        image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.darken),
          image:
              new NetworkImage(avail ? document.get("photoUrl") : testImageUrl),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            //  focusColor: Colors.black,
            // leading: Icon(Icons.arrow_drop_down_circle),
            onTap: () => Get.to(DetailPage(documentSnapshot: document)),
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      document.get("BussinessName").toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    RatingBarIndicator(
                        rating:
                            double.parse((document.get("rating").toString())),
                        itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        itemCount: 5,
                        itemSize: 14.0,
                        unratedColor: Colors.white10.withAlpha(50),
                        direction: Axis.horizontal //: Axis.horizontal,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.home,
                      color: MyColors.listp1Font,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "Line 1:" + document.get("Address").toString(),
                        style: TextStyle(
                          color: MyColors.listp1Font,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: MyColors.listp1Font,
                      size: 11,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      document.get("Contact"),
                      style:
                          TextStyle(color: MyColors.listp1Font, fontSize: 11),
                    )
                  ],
                )
              ],
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          //  Image.asset('assets/card-sample-image.jpg'),
          //Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
    );
  }
}
