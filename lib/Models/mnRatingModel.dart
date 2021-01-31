import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
class RestaurantRating {
  const RestaurantRating({@required this.restaurantId, this.rating});
  final String restaurantId;
  final double rating;
  factory RestaurantRating.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final double rating = data['rating'];
    return RestaurantRating(
      restaurantId: documentId,
      rating: rating,
    );
  }
}
