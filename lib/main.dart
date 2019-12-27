import 'dart:convert';

import 'package:epsilon/settings/settings_state.dart';
import 'package:epsilon/tools/reader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:epsilon/page/MapPage.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool ready = false;
  SharedPreferences prefs;
  SettingsState settingsState;
  Reader reader;
  String jsonFile;
  String language;
  Map<String, dynamic> map;
  int init;

  @override
  void initState() {
    super.initState();
    initEnv();
  }

  void initEnv() async {
    prefs = await SharedPreferences.getInstance();
    reader = new Reader();
    init = prefs.getInt('init') ?? 0;
    if (init == 0) {
      prefs.setString('language', 'eng');
      prefs.setInt('init', 1);
      language = 'eng';
    } else {
      language = prefs.getString('language');
    }
    jsonFile = await reader.getFileData('assets/strings/strings_eng');
    print(jsonFile);
    map = json.decode(jsonFile);
    settingsState = new SettingsState(
      language: 'eng',
      languageMap: map,
    );
    setState(() {
      ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'epsilon',
      theme: ThemeData(primaryColor: Colors.amber),
      home: SplashScreen(
        seconds: 1,
        backgroundColor: Colors.blue,
        navigateAfterSeconds: (!ready)
            ? Center(child: CircularProgressIndicator())
            : MapPage(
                settingsState: settingsState,
              ),
      ),
    );
  }
}
