import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsdriver/constants/constant.dart';
import 'package:ubereatsdriver/controller/sevices/geoFireServices/geoFireServices.dart';
import 'package:ubereatsdriver/controller/sevices/locationServices/locationServices.dart';
import 'package:ubereatsdriver/model/driverModel/driverModel.dart';
import 'package:ubereatsdriver/utils/colors.dart';
import 'package:ubereatsdriver/utils/textStyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.4, -122),
    zoom: 14,
  );
  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('Driver/${auth.currentUser!.uid}');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
              height: 10.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, event) {
                    if (event.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: black,
                        ),
                      );
                    }
                    if (event.data != null) {
                      DriverModel driverData = DriverModel.fromMap(
                          jsonDecode(jsonEncode(event.data!.snapshot.value))
                              as Map<String, dynamic>);

                      if (driverData.driverStatus == 'ONLINE') {
                        return SwipeButton(
                          thumbPadding: EdgeInsets.all(1.w),
                          thumb: Icon(Icons.chevron_right, color: white),
                          inactiveThumbColor: black,
                          activeThumbColor: black,
                          inactiveTrackColor: greyShade3,
                          activeTrackColor: greyShade3,
                          elevationThumb: 2,
                          elevationTrack: 2,
                          onSwipe: () {
                            GeofireServices.goOffline();
                          },
                          child: Text(
                            'Done for today',
                            style: AppTextStyles.body14Bold,
                          ),
                        );
                      } else {
                        return SwipeButton(
                          thumbPadding: EdgeInsets.all(1.w),
                          thumb: Icon(Icons.chevron_right, color: white),
                          inactiveThumbColor: black,
                          activeThumbColor: black,
                          inactiveTrackColor: greyShade3,
                          activeTrackColor: greyShade3,
                          elevationThumb: 2,
                          elevationTrack: 2,
                          onSwipe: () {
                            GeofireServices.goOnline();
                            GeofireServices.updateLocationRealtime(context);
                          },
                          child: Text(
                            'Go Online',
                            style: AppTextStyles.body14Bold,
                          ),
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: black,
                      ),
                    );
                  })),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) async {
                googleMapController.complete(controller);
                mapController = controller;
                Position crrposition =
                    await LocationServices.getCurrentLocation();
                LatLng crrLatlng = LatLng(
                  crrposition.latitude,
                  crrposition.longitude,
                );
                CameraPosition cameraPosition = CameraPosition(
                  target: crrLatlng,
                  zoom: 14,
                );
                mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
              },
            ),
          )
        ],
      )),
    );
  }
}
