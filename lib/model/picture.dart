import 'package:flutter/material.dart';

class Picture {
  Picture({@required this.id, @required this.path});

  final int id;
  final String path;

  Map<String, dynamic> toMap() {
    return {
      'img_id' : id,
      'img_path' : path,
    };
  }

  static Picture fromMap(Map<String, dynamic> map) {
    return new Picture(
      id: map['img_id'],
      path: map['img_path'],
    );
  }
}
