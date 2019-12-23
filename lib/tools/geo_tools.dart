import 'package:epsilon/model/shop.dart';

class GeoTools {

  void initSitesGeoPos(List<Shop> shops) {
    for (int i = 0; i < shops.length; i++) {
      shops[i].lat = double.parse(shops[i].gpsLocation.split(',')[0]);
      shops[i].lng = double.parse(shops[i].gpsLocation.split(',')[1]);
    }
  }

}