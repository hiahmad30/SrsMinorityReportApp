
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorityreport/Models/ratingModel.dart';

import 'users.dart';

class DatabaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(UserModel user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'displayName': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'accountCreated': Timestamp.now(),
        'GeoLocation': user.geoPoints,
      });
      retVal = "success";
    } catch (error) {
      print(error.toString());
      return null;
    }

    return retVal;
  }

  Future<String> createBussinessList(RatingModel bussinesslist) async {
    String retVal = "error";

    try {
      await _firestore.collection("Bussiness List").doc().set({
        'BussinessName': bussinesslist.bussinessName,
        'email': bussinesslist.email,
        'Address': bussinesslist.address,
        'Category': bussinesslist.bCategory,
        'City': bussinesslist.city,
        'Country': bussinesslist.country,
        'Zip': bussinesslist.zip,
        'State': bussinesslist.state,
        'ShortDiscription': bussinesslist.shortDisc,
        'Website': bussinesslist.website,
        'DetailedDiscription': bussinesslist.detailDescription,
        'photoUrl': bussinesslist.photoUrl,
        'Contact': bussinesslist.phone,
        'rating': bussinesslist.ratingBar,
        'RatingCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (error) {
      print(error.toString());
      return null;
    }

    return retVal;
  }

  final String uid;

  DatabaseService({this.uid});
}
