import 'dart:async';
import 'dart:convert';
import 'package:epsilon/database/db_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:epsilon/model/shop.dart';
import './bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'data_event.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DbManager _dbManager = DbManager();

  @override
  DataState get initialState => InitialDataState();

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    switch (event) {
      case DataEvent.loadData:
        yield InitialDataState();
        yield* _loadData();
        break;
      case DataEvent.envInitiated:
        yield* _initState();
        break;
    }
  }

  Stream<DataState> _loadData() async* {
    print("enter0");

    var shopUrl = "https://matcha.defaoui.com/api/guest/titi";

    //_dbManager.deleteAllShop();

    List<Shop> shops = await _dbManager.getAllShops();

    print("enter1");
    if (shops == null || shops.length == 0) {
      print("enter2");
      try {
        var response = await http.get(shopUrl);
        print("response code == ${response.statusCode}");
        print(response.body);
        if (response.statusCode == 200) {
          print("enter3");
          Map<String, dynamic> body = json.decode(response.body);
          print("body : $body");
          Iterable jsonResponse = body['shops'];
          print('>>> success! >>> $jsonResponse');
          try {
            shops = jsonResponse.map((x) => Shop.fromMap(x)).toList();
            print(shops.length);
            for (int i = 0; i < shops.length; i++)
              _dbManager.insertShop(shops[i]);
          } catch (e) {
            print("Error in converting shops: $e");
          }
        } else {
          print('>>> fail?');
        }
      } catch (e) {
        print("global error : $e");
      }
    } else
      print("Shops data is already there : length = ${shops.length}");

    yield AfterLoading();
  }

  Stream<DataState> _initState() async* {
    yield DataLoaded();
  }
}
