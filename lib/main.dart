import 'package:flutter/material.dart';

import 'package:epsilon/page/MapPage.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'epsilon',
      theme: ThemeData(primaryColor: Colors.amber),
      home: MapPage(),
    );
  }
}
