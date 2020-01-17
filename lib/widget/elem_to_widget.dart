import 'dart:io';

import 'package:epsilon/model/picture.dart';
import 'package:epsilon/model/shop.dart';
import 'package:epsilon/widget/shop_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ElemToWidget {
  Widget getShopWidget(BuildContext context, Shop shop, double height,
      double width, Function onClick) {
    return ShopWidget(
      context: context,
      shop: shop,
      onClick: onClick,
      height: height,
      width: width,
    ).build(context);
  }

  Widget getImageSlider(List<Picture> pictures, double height, double width) {
    return CarouselSlider(
      height: height,
      items: pictures.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.black38,
                image: DecorationImage(
                    image: (i.localPath != null)
                        ? FileImage(new File(i.localPath))
                        : NetworkImage('https://' + i.path),
                    fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
      viewportFraction: 1.0,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 4),
      pauseAutoPlayOnTouch: Duration(seconds: 2),
    );
  }
}
