import 'package:epsilon/model/shop.dart';
import 'package:flutter/material.dart';

class InfoWidget {
  InfoWidget({
    @required this.shop,
    @required this.height,
    @required this.width,
    @required this.onClick,
    @required this.type,
  });

  final Shop shop;
  final double height;
  final double width;
  final Function onClick;
  final int type;

  Widget build() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,//(type == 0) ? Color(0xff2f5983) : Colors.white,
        borderRadius: (type == 0)
            ? new BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            : new BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: height / 2,
            width: width,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Align(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 0, 3),
                          child: Text(
                            '${shop.title}',
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold',
                              fontSize: 18,
                              color: Colors.black54,//(type == 0) ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Text('${shop.rating}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black38,//(type == 0) ? Colors.white : Colors.black38,
                                  fontSize: 12,
                                )),
                            Container(
                              height: 12,
                              width: 3,
                            ),
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/star_yellow.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (type == 0) ? true : false,
                  child: GestureDetector(
                    onTap: () {
                      onClick(0, shop);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 4, 12, 0),
                        child: Icon(
                          Icons.remove,
                          color: Colors.black54,//(type == 0) ? Colors.white : Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height / 4,
            width: width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Text(
                'Opening time : 09:00 - 20:00',
                style: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 12,
                  color: Colors.black54,//(type == 0) ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
          Container(
            height: height / 4,
            width: width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Text(
                'Estimated price : 12 MAD',
                style: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 12,
                  color: Colors.black54,//(type == 0) ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
