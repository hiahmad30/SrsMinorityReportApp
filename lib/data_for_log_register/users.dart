import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  Timestamp accountCreated;
  String displayName;
  String phoneNumber;
  String photoUrl;
  String geoPoints;

  UserModel(
      {this.uid,
      this.email,
      this.accountCreated,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.geoPoints});

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.get('email');
    accountCreated = doc.get('accountCreated');
    displayName = doc.get('displayName');
    phoneNumber = doc.get('phoneNumber');
    geoPoints = doc.get('geoPoints');
  }
}
