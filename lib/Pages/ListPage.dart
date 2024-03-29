import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minorityreport/Pages/DetailEnter.dart';
import 'package:minorityreport/Utils/Consts.dart';
import 'package:minorityreport/ViewModel/loadinWidget.dart';
import 'package:minorityreport/controller/AuthController.dart';
import 'package:minorityreport/controller/ListController.dart';
import 'package:minorityreport/controller/dbController.dart';

import 'DetailPage.dart';
import 'login_page.dart';

class RatingList extends StatefulWidget {
  final String category;

  const RatingList({Key key, this.category}) : super(key: key);
  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  final auth = Get.put(AuthController());
  final db = Get.put(DatabaseController());
  TextEditingController searchController = TextEditingController();
  String searchString = "";
  Map<String, dynamic> resultList = Map<String, dynamic>();
  bool isSearchable = false;
  AsyncSnapshot<dynamic> resultListGet(AsyncSnapshot<dynamic> initString) {
    // resultList = initString;
  }
  _onSearchChanged() {
    print(searchController.text);
  }

  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String category = widget.category != null ? widget.category : '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome to Minority Report",
          style: GoogleFonts.roboto(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          u_id != null
              ? IconButton(
                  tooltip: 'SignOut',
                  icon: Icon(Icons.login_outlined),
                  onPressed: () async {
                    await auth.signouUser().then((value) {
                      setState(() {});
                    });
                  })
              : Container(),
        ],
        backgroundColor: MyColors.PrimaryColor,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: searchController,

                    //autovalidate: true,
                    onChanged: (value) => {if (mounted) setState(() {})},
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Text(
                      "Listing",
                      style:
                          GoogleFonts.ubuntu(fontSize: 24, color: Colors.black),
                    )),
                    Row(
                      children: [
                        Container(
                          width: 50,
                        ),
                        InkWell(
                            onTap: () async {
                              if (u_id == "" || u_id == null) {
                                await showMyDialog(
                                    context, "Alert", "Please Login First");
                                await Get.to(LoginPage()).then((value) {
                                  setState(() {});
                                });
                              } else {
                                Get.to(DetailEntry(
                                  categoryEntry: widget.category != null
                                      ? widget.category
                                      : '',
                                ));
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
                Flexible(
                  child: GetX<ListController>(
                    init: Get.put<ListController>(ListController()),
                    builder: (ListController listController) {
                      if (listController != null &&
                          listController.rating != null) {
                        return ListView.builder(
                            itemCount: listController.rating.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (widget.category != null) {
                                if (listController.rating.docs[index]
                                        .get('Category') ==
                                    widget.category) {
                                  return listController.rating.docs[index]
                                          .get('BussinessName')
                                          .toLowerCase()
                                          .contains(searchController.text
                                              .toLowerCase())
                                      ? _CardList(
                                          context,
                                          listController.rating.docs[index],
                                        )
                                      : Container();
                                } else
                                  return Container();
                              } else {
                                return listController.rating.docs[index]
                                        .get('BussinessName')
                                        .toLowerCase()
                                        .contains(
                                            searchController.text.toLowerCase())
                                    ? _CardList(
                                        context,
                                        listController.rating.docs[index],
                                      )
                                    : Container();
                              }
                            });
                      } else {
                        return Container(
                          child: LoadingWidget(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyButtons.footer(context),
    );
  }

  Widget _CardList(BuildContext context, DocumentSnapshot document) {
    String a = document.get("photoUrl");
    // double radioGroupV = db.calculateBlackExp(
    //     int.parse(document.get("blackExperience").toString()));

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
          image: new NetworkImage(a != null ? a : testImageUrl),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            //  focusColor: Colors.black,
            // leading: Icon(Icons.arrow_drop_down_circle),
            onTap: () => Get.to(() => DetailPage(documentSnapshot: document)),
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
                        document.get("Address").toString(),
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
                width: Get.width * 0.01,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
