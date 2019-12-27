import 'dart:async';

import 'dart:core';
import 'dart:typed_data';
import 'package:epsilon/map/polyline_effect.dart';
import 'package:epsilon/model/category.dart';
import 'package:epsilon/model/picture.dart';
import 'package:epsilon/model/shop.dart';
import 'package:epsilon/model/steps.dart';
import 'package:epsilon/model/xcolor.dart';
import 'package:epsilon/page/shopPage.dart';
import 'package:epsilon/settings/settings_state.dart';
import 'package:epsilon/tools/network_tools.dart';
import 'package:epsilon/widget/btn_widget.dart';
import 'package:epsilon/widget/elem_to_widget.dart';
import 'package:epsilon/tools/geo_tools.dart';
import 'package:epsilon/widget/shop_widget.dart';
import 'package:epsilon/widget/x_list.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:floating_bubble/floating_bubble.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  MapPage({
    @required this.settingsState,
  });

  final SettingsState settingsState;

  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  // Permissions Params

  PermissionStatus _status;

  // Map Params

  double _zoom = 15;

  // Widget Params

  ShopWidget shopWidget;
  bool shopVisibility = false;

  //Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;
  LatLng _centre;
  Position currentLocation;
  MapType _currentMapType = MapType.normal;
  FutureOr<GoogleMapController> get controller => null;
  String _mapStyle;

  // Markers Params

  final Set<Marker> _markers = {};
  Marker userPos;
  List<String> paths = [
    'assets/icons/marker_here.png',
    'assets/icons/marker_berrad.png',
  ];
  List<Uint8List> markerIcons = [];
  int clickedMarker = 0;

  // Polyline Params

  List<LatLng> latLng = [];
  final Set<Polyline> _polyline = {};

  // List Params

  XList xList;
  List<Widget> list = [];
  List<Shop> shops = [
    new Shop(
      id: 0,
      title: 'l\'Hssen',
      gpsLocation: '32.8989795,-6.9139437',
      rating: 4.5,
      categories: [
        Category(
          id: 0,
          title: 'atay cha3ra',
        ),
      ],
      images: [
        Picture(
          id: 0,
          path: 'https://i.skyrock.net/9758/72509758/pics/2907926791_1.jpg',
        ),
      ],
    ),
  ];

  // Tools

  ElemToWidget elemToWidget;
  GeoTools geoTools;

  // Other Params

  SettingsState settingsState;
  double height;
  double width;
  BuildContext context;
  NetworkTools network;

  // check permissions
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    settingsState = widget.settingsState;
    elemToWidget = new ElemToWidget();
    network = new NetworkTools();
    geoTools = new GeoTools();
    rootBundle.loadString('assets/map/map_style_silver').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
    // Check location permission has been granted
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup
            .locationWhenInUse) //check permission returns a Future
        .then(_updateStatus); // handling in callback to prevent blocking UI
    //getUserLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserLocation();
  }

  // method that is called on map creation and takes a MapController as a parameter
//  void _onMapCreated(GoogleMapController controller) {
//    PermissionHandler()
//        .checkPermissionStatus(PermissionGroup
//            .locationWhenInUse) //check permission returns a Future
//        .then(_updateStatus); // handling in callback to prevent blocking UI
//    //_mapController.complete(controller); // manages camera function (position, animation, zoom).
//  }

  // get Markers
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<List<Uint8List>> iconToBit(List<String> links) async {
    List<Uint8List> list = [];
    for (int i = 0; i < links.length; i++) {
      list.add(await getBytesFromAsset(links[i], 120));
    }
    return list;
  }

  void initMarkers(List<String> paths) async {
    if (markerIcons.length == 0) markerIcons.addAll(await iconToBit(paths));
    for (int i = 1; i < markerIcons.length; i++) {
      _markers.add(new Marker(
        onTap: () {
          print('### SHOP MARKER CLICKED ###');
          initShop(context, shops[i - 1]);
        },
        markerId: MarkerId('$i'),
        icon: BitmapDescriptor.fromBytes(markerIcons[i]),
        position: new LatLng(shops[i - 1].lat, shops[i - 1].lng),
      ));
    }
    userPos = new Marker(
      markerId: MarkerId('0'),
      icon: BitmapDescriptor.fromBytes(markerIcons[0]),
      position: new LatLng(_centre.latitude, _centre.longitude),
    );
    _markers.add(userPos);
    setState(() {});
    updateUserLocation();
  }

  // Shop List

  void initList(BuildContext context) {
    list.clear();
    geoTools.initSitesGeoPos(shops);
    print('shops len ==>> ${shops.length}');
    for (int i = 0; i < shops.length; i++) {
      list.add(elemToWidget.getShopWidget(
          context, shops[i], height, width, shopCallback));
    }
    xList = new XList(
      context: context,
      list: list,
      onClick: null,
    );
  }

  // Init Widget

  void initShop(BuildContext context, Shop shop) {
    getRoad(_centre, new LatLng(shop.lat, shop.lng));
    //_getPolyline(_centre, new LatLng(shop.lat, shop.lng));
    setState(() {
      shopWidget = new ShopWidget(
          context: context,
          shop: shop,
          onClick: shopCallback,
          height: height,
          width: width);
      shopVisibility = true;
    });
  }

  // Callback functions

  void shopCallback(int access, Shop shop) {
    if (access == 0) {
      setState(() {
        _polyline.clear();
        latLng.clear();
        shopVisibility = false;
      });
    } else if (access == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShopPage(
                    shop: shops[clickedMarker],
                  )));
    }
  }

  // Location

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  //TODO: Get Users' location
  void getUserLocation() async {
    _markers.clear();
    currentLocation = await locateUser();
    setState(() {
      _centre = LatLng(currentLocation.latitude ?? 53.467125,
          currentLocation.longitude ?? -2.233966);
    });
    print('centre $_centre');
    initMarkers(paths);
  }

  void updateUserLocation() async {
    while (true) {
      currentLocation = await locateUser();
      setState(() {
        _markers.remove(userPos);
        _centre = LatLng(currentLocation.latitude ?? 53.467125,
            currentLocation.longitude ?? -2.233966);
        userPos = new Marker(
          markerId: MarkerId('0'),
          icon: BitmapDescriptor.fromBytes(markerIcons[0]),
          position: new LatLng(_centre.latitude, _centre.longitude),
        );
        _markers.add(userPos);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    initList(context);
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            currentLocation == null
                ? Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      //_mapController.complete(controller);
                      mapController = controller;
//                  mapController.setMapStyle(
//                      '[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');
                      if (_mapStyle != null && controller != null) {
                        print('#### SET_MAP_STYLE ####');
                        mapController.setMapStyle(_mapStyle);
                      }
                    },
                    initialCameraPosition: // required parameter that sets the starting camera position. Camera position describes which part of the world you want the map to point at.
                        CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: _zoom,
                            tilt: 0.0),
                    markers: _markers,
                    polylines: _polyline,
                    scrollGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    myLocationEnabled: false,
                    mapType: _currentMapType,
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraMove: (CameraPosition position) {
                      _zoom = position.zoom;
                    },
                  ),
            Visibility(
              visible: shopVisibility,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 40),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 140,
                    child: elemToWidget.getShopWidget(
                        context, shops[0], height, width, shopCallback),
                  ),
                ),
              ),
            ),
            FloatingBubble(
              child: PreferredSize(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    height: 140,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        BtnWidget(
                          width: 40,
                          height: 40,
                          text: null,
                          icon: Icons.my_location,
                          size: 20,
                          onClick: _myLocation,
                        ).build(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: BtnWidget(
                            width: 40,
                            height: 40,
                            text: null,
                            icon: Icons.add,
                            size: 20,
                            onClick: _zoomIn,
                          ).build(),
                        ),
                        BtnWidget(
                          width: 40,
                          height: 40,
                          text: null,
                          icon: Icons.remove,
                          size: 20,
                          onClick: _zoomOut,
                        ).build(),
                      ],
                    ),
                  ),
                ),
                preferredSize: Size(55, 140),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // check permissions when app is resumed
  // this is when permissions are changed in app settings outside of app
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      PermissionHandler()
          .checkPermissionStatus(PermissionGroup.locationWhenInUse)
          .then(_updateStatus);
    }
    print("STATE -> $state");
  }

  void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    if (status != PermissionStatus.granted) {
      // On iOS if "deny" is pressed, open App Settings
      PermissionHandler().openAppSettings();
    } else {
      //_updateStatus(status);
      print("STATUS -> $status");
    }
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      // check status has changed
      setState(() {
        _status = status; // update
        //_onMapCreated(controller);
      });
    } else {
      if (status != PermissionStatus.granted) {
        print("REQUESTING PERMISSION");
        _askPermission();
      }
    }
  }

  // Callback Functions

  Future<void> _myLocation() async {
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: _zoom,
          tilt: 0.0),
    ));
  }

  void _zoomIn() async {
    if (_zoom <= 19) {
      _zoom = _zoom + 1;
      final GoogleMapController controller = mapController;
      LatLng latLng = await _currentCameraPosition();
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: _zoom, tilt: 0.0),
      ));
    }
  }

  void _zoomOut() async {
    if (_zoom >= 3) {
      _zoom = _zoom - 1;
      final GoogleMapController controller = mapController;
      LatLng latLng = await _currentCameraPosition();
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: _zoom, tilt: 0.0),
      ));
    }
  }

  Future<LatLng> _currentCameraPosition() async {
    final GoogleMapController controller = mapController;
    LatLngBounds latLngBounds = await controller.getVisibleRegion();
    LatLng latLng = new LatLng(
        (latLngBounds.northeast.latitude + latLngBounds.southwest.latitude) / 2,
        (latLngBounds.northeast.longitude + latLngBounds.southwest.longitude) /
            2);
    return latLng;
  }

  // Road Scan

  Future<List<Steps>> loopRoadScan(LatLng start, LatLng end) async {
    List<Steps> result = [];
    try {
      await network
          .get("origin=" +
              start.latitude.toString() +
              "," +
              start.longitude.toString() +
              "&destination=" +
              end.latitude.toString() +
              "," +
              end.longitude.toString() +
              "&key=AIzaSyB940mpfv4pNgFIHTLI2v0nEXcAiQaYMjE")
          .then((dynamic res) {
        //print(res.length.toString() + ' + ' + result.length.toString());
        if (res != null && res.length > 0) result.addAll(res);
        //print(result.length.toString());
      });
    } catch (e) {
      print(e);
    }
    //print('result => ' + result.length.toString());
    return Future.delayed(Duration(milliseconds: 1000), () => result);
  }

  void getRoad(LatLng start, LatLng end) {
    loopRoadScan(start, end).then((value) {
      List<Steps> rr = value;
      for (final i in rr) {
        latLng.add(i.startLocation);
        latLng.add(i.endLocation);
      }

      setState(() {
        PolylineEffect polylineEffect = new PolylineEffect(
          startColor: new XColor(r: 47, g: 89, b: 131),
          endColor: new XColor(r: 254, g: 204, b: 0),
          list: latLng,
        );
        _polyline.addAll(polylineEffect.polylineList());
      });
    });
  }
}
