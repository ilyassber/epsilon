import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {

  PermissionStatus _status;
  Completer<GoogleMapController> _mapController = Completer();

  LatLng _centre;
  Position currentLocation;
  MapType _currentMapType = MapType.normal;

  FutureOr<GoogleMapController> get controller => null;

// check permissions
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    // Check location permission has been granted
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup
        .locationWhenInUse) //check permission returns a Future
        .then(_updateStatus); // handling in callback to prevent blocking UI
  }

  //double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  // method that is called on map creation and takes a MapController as a parameter
  void _onMapCreated(GoogleMapController controller) {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup
        .locationWhenInUse) //check permission returns a Future
        .then(_updateStatus); // handling in callback to prevent blocking UI

    _mapController.complete(
        controller); // manages camera function (position, animation, zoom).
  }


  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  //TODO: Get Users' location
  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _centre = LatLng(currentLocation.latitude ?? 53.467125,
          currentLocation.longitude ?? -2.233966);
    });
    print('centre $_centre');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        currentLocation == null
            ? CircularProgressIndicator()
            : GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: // required parameter that sets the starting camera position. Camera position describes which part of the world you want the map to point at.
          CameraPosition(
              target: _centre,
              zoom: 14.5,
              tilt: 0.0), //LatLng(53.467125, -2.233966)
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          mapType: _currentMapType,
          zoomGesturesEnabled: true,
        ),
//        GoogleMap(
//          onMapCreated: _onMapCreated,
//          initialCameraPosition: // required parameter that sets the starting camera position. Camera position describes which part of the world you want the map to point at.
//          CameraPosition(
//              target: LatLng(53.467125, -2.233966), zoom: 14.5, tilt: 0.0),
//          scrollGesturesEnabled: true,
//          tiltGesturesEnabled: true,
//          compassEnabled: true,
//          rotateGesturesEnabled: true,
//          myLocationEnabled: true,
//          mapType: _currentMapType,
//          zoomGesturesEnabled: true,
//        ),
      ],
    );
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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

  /*void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
  }*/

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
        _onMapCreated(controller);
      });
    } else {
      if (status != PermissionStatus.granted) {
        print("REQUESTING PERMISSION");
        PermissionHandler().requestPermissions(
            [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
      }
    }
  }
}