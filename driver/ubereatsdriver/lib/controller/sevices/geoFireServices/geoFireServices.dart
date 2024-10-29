import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ubereatsdriver/constants/constant.dart';
import 'package:ubereatsdriver/controller/provider/rideProvider/rideProvider.dart';
import 'package:ubereatsdriver/controller/sevices/locationServices/locationServices.dart';

class GeofireServices {
  static DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref()
      .child('Driver/${auth.currentUser!.uid}/driverStatus');

  static goOnline() async {
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.initialize('OnlineDrivers');
    Geofire.setLocation(
      auth.currentUser!.uid,
      currentPosition.latitude,
      currentPosition.longitude,
    );
    databaseReference.set('ONLINE');
    databaseReference.onValue.listen((event) {});
  }

  static goOffline() {
    Geofire.removeLocation(auth.currentUser!.uid);
    databaseReference.set('OFFLINE');
    databaseReference.onDisconnect();
  }

  static updateLocationRealtime(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );
    StreamSubscription<Position> driverPositionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((event) {
      Geofire.setLocation(
        auth.currentUser!.uid,
        event.latitude,
        event.longitude,
      );
      context.read<RideProvider>().updateCurrentPosition(event);
    });
  }
}
