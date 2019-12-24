import 'package:epsilon/model/comment.dart';
import 'package:flutter/material.dart';

class CommentWidget {
  CommentWidget({
    @required this.comment,
    @required this.height,
    @required this.width,
  });

  final Comment comment;
  final double height;
  final double width;

  Widget build() {
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    comment.name,
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      color: Colors.black54,
                      fontSize: height / 8,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    comment.date,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black26,
                      fontSize: height / 8,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                comment.city,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black26,
                  fontSize: height / 10,
                ),),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                comment.comment,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black38,
                  fontSize: height / 8,
                ),),
            ),),
          ],
        ),
      ),
    );
  }
}
