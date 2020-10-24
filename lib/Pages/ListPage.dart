import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minorityreport/Utils/Consts.dart';

import 'DetailPage.dart';
import 'First_Page.dart';
import 'login_page.dart';

class RatingList extends StatefulWidget {
  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {


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
            // child: InkWell(
            //     onTap: () {
            //       if (u_id != null) Navigator.pushNamed(context, '/AddList');
            //       //  else
            //       //    Alert(context: context, title: "Login First");
            //     },
            //     child: Icon(Icons.add_comment)),
          )
        ],
        backgroundColor: MyColors.PrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              subtitle: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: Text(
                        "List of Bussiness",
                        style: GoogleFonts.ubuntu(
                            fontSize: 24, color: Colors.black),
                      )),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            child: InkWell(
                              hoverColor: MyColors.PrimaryColor,
                              onTap: () async {
                                await showMyDialog(
                                    context, "Alert", "Filter is comming soon");
                              },
                              child: Icon(
                                Icons.filter_list_rounded,
                                color: MyColors.PrimaryColor,
                                semanticLabel: "Filter List",
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                if (u_id == "" || u_id == null) {
                                  await showMyDialog(
                                      context, "Alert", "Please Login First");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  Navigator.pushNamed(context, '/AddList');
                                }
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_business,
                                    color: MyColors.PrimaryColor,
                                  ),
                                  Text(
                                    "Add new",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection("Bussiness List")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Text('Loading.....');
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemExtent: 160,
                              itemBuilder: (context, index) => _CardList(
                                  context, snapshot.data.documents[index]));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyButtons.footer(context),
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
      margin: EdgeInsets.all(8),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),

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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(documentSnapshot: document))),
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.get("BussinessName").toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
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
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "Line 1:" + document.get("Address").toString(),
                        style: TextStyle(
                          color: MyColors.listp1Font,
                          fontSize: 16,
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
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      document.get("Contact"),
                      style: TextStyle(color: MyColors.listp1Font),
                    )
                  ],
                )
              ],
            ),
          ),

          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              RatingBarIndicator(
                  rating: double.parse((document.get("rating").toString())),
                  itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  itemCount: 5,
                  itemSize: 14.0,
                  unratedColor: Colors.white10.withAlpha(50),
                  direction: Axis.horizontal //: Axis.horizontal,
                  ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
            ],
          ),
          //  Image.asset('assets/card-sample-image.jpg'),
          //Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
    );
  }
}
