import 'package:flutter/material.dart';

class Picture {
  Picture({@required this.id, @required this.path, @required this.localPath});

  int id;
  String path;
  String localPath;

  Map<String, dynamic> toMap() {
    return {
      'img_id' : id,
      'img_path' : path,
      'local_path': localPath,
    };
  }

  static Picture fromMap(Map<String, dynamic> map) {
    return new Picture(
      id: map['img_id'],
      path: map['img_path'],
      localPath: map['local_path'],
    );
  }
}
