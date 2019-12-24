import 'package:epsilon/model/shop.dart';
import 'package:epsilon/model/picture.dart';
import 'package:epsilon/tools/TextTools.dart';
import 'package:epsilon/tools/geo_tools.dart';
import 'package:epsilon/widget/info_widget.dart';
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
  final void Function(int, Shop shop) onClick;
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
      child: GestureDetector(
        onTap: () {
          onClick(1, shop);
        },
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
                    child: new InfoWidget(
                      width: width - 40 - 110,
                      height: height - 40,
                      shop: shop,
                      onClick: onClick,
                      type: 0,
                    ).build(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  elevation: 7.0,
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.black.withOpacity(0.99),
                  child: Container(
                    width: 110,
                    height: height,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(20),
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
      ),
    );
  }
}
