import 'package:flutter/material.dart';

class Comment {
  Comment({
    @required this.name,
    @required this.city,
    @required this.date,
    @required this.comment,
  });

  final String name;
  final String city;
  final String date;
  final String comment;

  Map toMap() {
    return {
      'name': name,
      'city': city,
      'date': date,
      'comment': comment,
    };
  }

  Comment fromMap(Map<dynamic, String> map) {
    return Comment(
      name: map['name'],
      city: map['city'],
      date: map['date'],
      comment: map['comment'],
    );
  }
}
