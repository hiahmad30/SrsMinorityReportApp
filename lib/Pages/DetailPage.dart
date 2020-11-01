import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:minorityreport/Utils/Consts.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'login_page.dart';

class DetailPage extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController reviewContr = new TextEditingController();
  double _rating;
  addRev(BuildContext context) {
    return Alert(
        context: context,
        title: "Rate this Bussiness",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: reviewContr,
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              decoration: InputDecoration(
                labelText: 'Add review',
              ),
            ),
            RatingBar(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _rating = rating;

                print(_rating);
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (reviewContr.text.isNotEmpty) {
                addNewReviewdb(context);
              }
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  addNewReviewdb(BuildContext context) async {
    try {
      print("Uid " + u_id);
      await _firebaseFirestore.collection("Reviews").doc(u_id).set({
        "Rating": _rating,
        "BName": documentSnapshot.get("BussinessName"),
        "BussinessId": documentSnapshot.id,
        "Reviews": reviewContr.text
      }).then((value) {
        Navigator.pop(context);
        // print(_firebaseFirestore.collection("Reviews").doc(u_id).id.toString());
        // print(u_id);
        // print(value);
      });
    } catch (e) {
      print("object" + e.toString());
    }
  }

  // bool checkReplace() {
  //   if (_firebaseFirestore.collection("Reviews").doc(u_id).id.isEmpty) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  DetailPage({@required this.documentSnapshot});
  @override
  Widget build(BuildContext context) {
    var a = documentSnapshot.get("photoUrl");
    bool avail;
    if (a != null) {
      avail = true;
    } else {
      avail = false;
    }
    // final _size = MediaQuery.of(context).size;
    final topPhoto = Container(
      // height: _size.height,
      child: Image.network(avail ? a : testImageUrl),
    );
    final title = Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          documentSnapshot.get("BussinessName"),
          // style:
          //  GoogleFonts.breeSerif(fontSize: 20, fontWeight: FontWeight.bold),
          style: TextStyle(
              color: MyColors.p1FontBalck,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final about = Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          documentSnapshot.get("DetailedDiscription"),
          style: TextStyle(color: MyColors.p1FontBalck),
        ),
      ),
    );
    final rating = Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                if (u_id == "" || u_id == null) {
                  await showMyDialog(context, "Alert", "Please Login First");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  addRev(context);
                }
              }
              // else {
              //   Alert(
              //       context: context,
              //       title: "Error",
              //       desc: "You already reviewed");
              // }
              ,
              child: RatingBarIndicator(
                  rating:
                      double.parse((documentSnapshot.get("rating").toString())),
                  itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  itemCount: 5,
                  itemSize: 24.0,
                  unratedColor: Colors.grey.withAlpha(50),
                  direction: Axis.horizontal //: Axis.horizontal,
                  ),
            ),
            Text(
              "    *click on rating to add reviews",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );

    final cotactcard = Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(
                  width: 10,
                ),
                Text(documentSnapshot.get("email")),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone_iphone),
                SizedBox(
                  width: 10,
                ),
                Text(documentSnapshot.get("Contact")),
              ],
            ),
            Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 10,
                ),
                Text(documentSnapshot.get("Address")[0].toString() +
                    ", " +
                    documentSnapshot.get("Address")[1].toString()),
              ],
            ),
            Row(
              children: [
                Icon(Icons.map),
                SizedBox(
                  width: 10,
                ),
                Text(documentSnapshot.get("Country")),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
    final btns = Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // RaisedButton(
          //   onPressed: () => {},
          //   child: Text("Edit"),
          //   color: MyColors.PrimaryColor,
          // ),
          SizedBox(
            width: 20,
          ),
          RaisedButton(
            onPressed: () {
              if (u_id == "" || u_id == null) {
                Alert(
                  context: context,
                  title: "Login First",
                  desc: "Please Login before adding review",
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                Navigator.pushNamed(context, '/AddList');
              }
            },
            child: Text("Add New"),
            color: MyColors.PrimaryColor,
          ),
        ],
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topPhoto,
            title,
            SizedBox(
              height: 20,
            ),
            about,
            SizedBox(
              height: 0,
            ),
            rating,
            SizedBox(
              height: 0,
            ),
            cotactcard,
            SizedBox(
              height: 10,
            ),
            btns,
          ],
        ),
      ),
      bottomNavigationBar: MyButtons.footer(context),
    );
  }
}
