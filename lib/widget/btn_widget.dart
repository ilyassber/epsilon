import 'package:flutter/material.dart';

class BtnWidget {
  BtnWidget({
    @required this.height,
    @required this.width,
    @required this.size,
    @required this.icon,
    @required this.text,
    @required this.onClick,
  });

  final double height;
  final double width;
  final double size;
  final IconData icon;
  final String text;
  final Function onClick;

  Widget build() {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Color(0xff2f5983).withOpacity(0.7),
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff2f5983),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: (text == null)
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: size,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold',
                      color: Colors.white,
                      fontSize: size * 0.7,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
