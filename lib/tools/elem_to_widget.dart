import 'package:epsilon/model/shop.dart';
import 'package:epsilon/widget/shop_widget.dart';
import 'package:flutter/material.dart';

class ElemToWidget {
  Widget getShopWidget(
      BuildContext context, Shop shop, double height, double width, Function onClick) {
    return ShopWidget(
      context: context,
      shop: shop,
      onClick: onClick,
      height: height,
      width: width,
    ).build(context);
  }
}
