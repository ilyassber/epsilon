import 'package:epsilon/model/category.dart';
import 'package:epsilon/model/picture.dart';
import 'package:flutter/material.dart';

class Shop {
  Shop(
      {@required this.id,
      @required this.title,
      @required this.categories,
      @required this.images,
      @required this.gpsLocation,
      @required this.rating});

  final int id;
  final String title;
  final List<Category> categories;
  final List<Picture> images;
  final String gpsLocation;
  final double rating;
  double lat;
  double lng;
}
