import 'package:flutter/material.dart';

import 'MapPage.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'epsilon',
      theme: ThemeData(primaryColor: Colors.amber),
      home: MapPage(),
    );
  }
}