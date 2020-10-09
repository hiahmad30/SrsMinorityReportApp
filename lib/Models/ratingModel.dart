import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String docId;
  String bussinessName;
  String bCategory;
  var address;
  String city;
  String state;
  String country;
  String zip;
  String phone;
  String email;
  String website;
  String shortDisc;
  String detailDescription;
  String photoUrl;
  double ratingBar;

  Timestamp listUbdated;
  RatingModel(
      {this.docId,
      this.bussinessName,
      this.bCategory,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.phone,
      this.country,
      this.detailDescription,
      this.email,
      this.listUbdated,
      this.shortDisc,
      this.website,
      this.photoUrl,
      this.ratingBar});

  RatingModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    docId = doc.id;
    bussinessName = doc.get('Name');
    email = doc.get('Email');
    address = doc.get('Address');
    bCategory = doc.get('Category');
    city = doc.get('City');
    state = doc.get('State');
    country = doc.get('Country');
    zip = doc.get('Zip');
    phone = doc.get('Phone');
    email = doc.get('Email');
    website = doc.get('Website');
    shortDisc = doc.get('ShortDiscription');
    detailDescription = doc.get('DetailedDiscription');
    photoUrl = doc.get('photoUrl');
    ratingBar = doc.get('rating');
  }
}
