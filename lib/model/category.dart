import 'package:flutter/material.dart';

class Category {
  Category({@required this.id, @required this.title});

  final int id;
  final String title;

  Map<String, dynamic> toMap() {
    return {
      'category_id': id,
      'title': title,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
    );
  }
}
