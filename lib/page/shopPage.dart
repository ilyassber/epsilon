import 'package:epsilon/model/comment.dart';
import 'package:epsilon/model/shop.dart';
import 'package:epsilon/widget/btn_widget.dart';
import 'package:epsilon/widget/comment_widget.dart';
import 'package:epsilon/widget/elem_to_widget.dart';
import 'package:epsilon/widget/info_widget.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  ShopPage({
    @required this.shop,
  });
  final Shop shop;
  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  // General Params

  Shop shop;
  double height;
  double width;

  // Instructors Params

  ElemToWidget elemToWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    elemToWidget = new ElemToWidget();
    shop = widget.shop;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                elemToWidget.getImageSlider(shop.images, height * 0.6, width),
                GestureDetector(
                  child: Container(
                    alignment: Alignment(0, -0.2),
                    height: height * 0.4,
                    width: width,
                    child: CommentWidget(
                      comment: Comment(
                        name: 'Ilyass BERCHIDA',
                        city: 'Khouribga',
                        date: '24 DEC 2019',
                        comment: 'This place has a great tea with mint .. come to try it ;)',
                      ),
                      height: 100,
                      width: width - 20,
                    ).build(),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height / 7,
                width: width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.6, 1],
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.keyboard_backspace,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.2),
              child: Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(17.0),
                shadowColor: Colors.black.withOpacity(0.7),
                child: InfoWidget(
                  height: height / 7,
                  width: width * 0.7,
                  shop: shop,
                  onClick: onCallback,
                  type: 1,
                ).build(),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 1),
              child: Container(
                height: height / 7,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Container(
                          alignment: Alignment.center,
                          child: BtnWidget(
                            height: 50,
                            width: 50,
                            size: 20,
                            icon: Icons.favorite_border,
                            text: null,
                          ).build(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Container(
                          alignment: Alignment.center,
                          child: BtnWidget(
                            height: 50,
                            width: width - 110,
                            size: 20,
                            icon: Icons.favorite_border,
                            text: 'Comment',
                          ).build(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Callback Functions

  void onCallback(int access, Shop shop) {}
}
