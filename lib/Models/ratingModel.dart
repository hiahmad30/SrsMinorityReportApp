import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class RatingModel {
  String docId;
  String bussinessName;
  String bCategory;
  String address;
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

@immutable
class Restaurant {
  const Restaurant(
      {@required this.id,
      @required this.name,
      @required this.numRatings,
      this.avgRating});
  final String id;
  final String name;
  final int numRatings;
  final double avgRating;

  factory Restaurant.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final int numRatings = data['numRatings'] ?? 0;
    final double avgRating = (data['avgRating'] ?? 0).toDouble();
    return Restaurant(
      id: documentId,
      name: name,
      numRatings: numRatings,
      avgRating: avgRating,
    );
  }

  @override
  int get hashCode => hashValues(id, name, numRatings, avgRating);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Restaurant otherRestaurant = other;
    return id == otherRestaurant.id &&
        name == otherRestaurant.name &&
        numRatings == otherRestaurant.numRatings &&
        avgRating == otherRestaurant.avgRating;
  }

  @override
  String toString() =>
      'id: $id, name: $name, numRatings: $numRatings, avgRating: $avgRating';
}
