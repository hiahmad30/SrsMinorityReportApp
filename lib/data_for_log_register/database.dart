import 'package:cloud_firestore/cloud_firestore.dart';
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
    var bList = _firestore.collection("Bussiness List");
    try {
      await bList.doc().set({
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
    print(bList.doc().id);
    return retVal;
  }

  double _avgRating = 0;
  // getReview();
  Future<void> getReview(
    String id,
  ) async {
    int tem = 0;
    try {
      await Firestore.instance
          .collection("Reviews")
          .where("BussinessId", isEqualTo: id)
          .get()
          .then((value) async => {
                value.docs.forEach((element) {
                  var temp = element.data()["Rating"];
                  _avgRating += temp == null ? 3 : temp;
                  tem++;
                }),
                if (tem != 0) _avgRating = _avgRating / tem,
                await Firestore.instance
                    .collection("Bussiness List")
                    .doc(id)
                    .update({'rating': _avgRating}),
                print(value.docs.length.toString()),
              });
    } catch (e) {
      print("Not get reviews");
      _avgRating = 3;
    }
  }
}
