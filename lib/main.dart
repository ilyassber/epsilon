import 'dart:convert';

import 'package:epsilon/bloc/data_bloc.dart';
import 'package:epsilon/bloc/data_event.dart';
import 'package:epsilon/bloc/data_state.dart';
import 'package:epsilon/settings/settings_state.dart';
import 'package:epsilon/tools/reader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:epsilon/page/MapPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

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

  // Bloc

  DataBloc _dataBloc = DataBloc();

  @override
  void initState() {
    super.initState();
    _dataBloc.add(DataEvent.loadData);
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

  Widget bodyBuilder() {
    print("enter body builder");
    return BlocBuilder(
      bloc: _dataBloc,
      builder: (BuildContext context, DataState state) {
        if (state is InitialDataState) {
          return Container(
            color: Colors.black,
          );
        } else if (state is AfterLoading) {
          print("after loading");
          return SplashScreen(
            seconds: 1,
            navigateAfterSeconds:
            (!ready) ? Center(child: CircularProgressIndicator()) : MapPage(
              settingsState: settingsState,
            ),
            backgroundColor: Colors.black,
          );
        } else
          return Container(
            color: Colors.red,
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'epsilon',
      theme: ThemeData(primaryColor: Colors.amber),
      home: bodyBuilder(),
    );
  }
}
