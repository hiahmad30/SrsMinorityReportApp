import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:minorityreport/Models/ratingModel.dart';
import 'package:minorityreport/data_for_log_register/users.dart';

class DatabaseController extends GetxController {
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

  Future<bool> createBussinessList(RatingModel bussinesslist) async {
    bool retVal = false;
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
      }).then((value) {
        retVal = true;
      });

      return retVal;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  // getReview();
  Future<double> getReview(String id) async {
    double _avgRating = 0;
    int tem = 0;
    try {
      await FirebaseFirestore.instance
          .collection("Reviews")
          .where("BussinessId", isEqualTo: id)
          .get()
          .then((value) async => {
                value.docs.forEach((element) {
                  double temp = element.data()["Rating"].todouble;
                  _avgRating += temp == null ? 0 : temp;
                  tem++;
                }),
                if (tem != 0) _avgRating = _avgRating / tem,
                await FirebaseFirestore.instance
                    .collection("Bussiness List")
                    .doc(id)
                    .update({'rating': _avgRating}),
                print(value.docs.length.toString()),
              });
    } catch (e) {
      print("Not get reviews");
      _avgRating = 3;
    }
    return _avgRating;
  }

  double calculateBlackExp(int rValue) {
    return (rValue / 5) * 100;
  }
}
