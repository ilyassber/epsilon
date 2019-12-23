import 'package:epsilon/model/shop.dart';
import 'package:epsilon/model/picture.dart';
import 'package:epsilon/tools/TextTools.dart';
import 'package:epsilon/tools/geo_tools.dart';
import 'package:flutter/material.dart';

class ShopWidget {
  ShopWidget(
      {@required this.context,
      @required this.shop,
      @required this.onClick,
      @required this.height,
      @required this.width});

  final BuildContext context;
  final Shop shop;
  final void Function(int, double, double) onClick;
  final double height;
  final double width;
  List<Picture> images;

  TextTools textTools = new TextTools();
  GeoTools geoTools = new GeoTools();

  Widget build(BuildContext context) {
    context = this.context;
    double height = 140; //MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    images = shop.images;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        height: height,
        width: width - 40,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: new BorderRadius.only(
                    bottomRight: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: Container(
                    width: width - 40 - 110,
                    height: height - 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        bottomRight: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: (height - 40) / 2,
                          width: width - 40 - 110,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 8, 0, 3),
                                        child: Text(
                                          '${shop.title}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto-Bold',
                                            fontSize: 18,
                                            color: Colors.black54,
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
                                                color: Colors.black38,
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
                              GestureDetector(
                                onTap: () {
                                  onClick(0, 0.0, 0.0);
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 4, 12, 0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: (height - 40) / 4,
                          width: width - 40 - 110,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Text(
                              'Opening time : 09:00 - 20:00',
                              style: TextStyle(
                                fontFamily: 'Roboto-Medium',
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: (height - 40) / 4,
                          width: width - 40 - 110,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
                            child: Text(
                              'Estimated price : 12 MAD',
                              style: TextStyle(
                                fontFamily: 'Roboto-Medium',
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(17.0),
                shadowColor: Colors.black.withOpacity(0.99),
                child: Container(
                  width: 110,
                  height: height,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17),
                      topRight: Radius.circular(17),
                    ),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(images[0].path),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 110,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
//    return GestureDetector(
//      onTap: () {
//        onClick(shop.lat, shop.lng);
//      },
//      child: Padding(
//        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//        child: Material(
//          color: Color(0xffffffff), //Color(0xfff5f5f5),
//          elevation: 7.0,
//          borderRadius: BorderRadius.circular(12.0),
//          shadowColor: Color(0xfff5f5f5),
//          child: Stack(children: [
//            Container(
//              height: height,
//              width: width - 40,
//              decoration: BoxDecoration(
//                borderRadius: new BorderRadius.circular(12.0),
//                image: DecorationImage(
//                  image: AssetImage('assets/images/mosaic_02.jpg'),
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//            Container(
//              height: height,
//              width: width - 40,
//              decoration: BoxDecoration(
//                borderRadius: new BorderRadius.circular(12.0),
//                color: Colors.blueGrey.withOpacity(0.9),
//              ),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Container(
//                    width: 110,
//                    height: height,
//                    child: ClipRRect(
//                      borderRadius: new BorderRadius.only(
//                        topLeft: Radius.circular(12),
//                        bottomLeft: Radius.circular(12),
//                      ),
//                      child: Image(
//                        fit: BoxFit.fill,
//                        image: NetworkImage(images[0].path),
//                      ),
//                    ),
//                  ),
//                  Container(
//                    child: Padding(
//                      padding:
//                          const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
//                      child: Container(
//                        width: width - 20 - 40,
//                        height: 140,
//                        child: Column(
//                          children: <Widget>[
//                            Align(
//                              alignment: Alignment.center,
//                              child: Container(
//                                alignment: Alignment.center,
//                                width: 164,
//                                height: 30,
//                                child: Text('${shop.title}',
//                                    style: TextStyle(
//                                      color: Colors.black38,
//                                      fontSize: 26,
//                                      fontWeight: FontWeight.bold,
//                                    )),
//                              ),
//                            ),
//                            Align(
//                              alignment: Alignment.center,
//                              child: Container(
//                                alignment: Alignment.center,
//                                width: 164,
//                                height: 30,
//                                child: Row(
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text('${shop.rating}',
//                                        style: TextStyle(
//                                          color: Colors.black38,
//                                          fontSize: 20,
//                                          fontWeight: FontWeight.bold,
//                                        )),
//                                    Container(
//                                      alignment: Alignment.center,
//                                      height: 30,
//                                      width: 5,
//                                    ),
//                                    Container(
//                                      alignment: Alignment.center,
//                                      height: 22,
//                                      width: 22,
//                                      decoration: BoxDecoration(
//                                        image: DecorationImage(
//                                          image: AssetImage(
//                                              'assets/icons/star_yellow.png'),
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Align(
//                              alignment: Alignment.center,
//                              child: Container(
//                                alignment: Alignment.center,
//                                width: 164,
//                                height: 30,
//                                child: Text('open',
//                                    style: TextStyle(
//                                      color: Colors.black38,
//                                      fontSize: 16,
//                                      fontWeight: FontWeight.bold,
//                                    )),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ]),
//        ),
//      ),
//    );
  }
}
