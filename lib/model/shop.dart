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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'gps_location': gpsLocation,
      'rating': rating,
      'images': images.map((x) => x.toMap()).toList(),
      'categories': [],//categories.map((x) => x.toMap()).toList(),
    };
  }

  static Shop fromMap(Map<String, dynamic> map) {
    List<Picture> images = [];
    List<Category> categories = [];
    try {
      Iterable value = map['images'];
      images.addAll(value.map((x) => Picture.fromMap(x)).toList());
      //value = map['categories'];
      //categories.addAll(value.map((x) => Category.fromMap(x)).toList());
    } catch (e) {
      print("Error : $e");
    }
    return Shop(
      id: map['id'],
      title: map['title'],
      gpsLocation: map['gps_location'],
      rating: double.parse(map['rating'].toString()),
      images: images,
      categories: categories,
    );
  }
}
