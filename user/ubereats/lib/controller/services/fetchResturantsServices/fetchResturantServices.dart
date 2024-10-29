import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ubereats/constants/constant.dart';
import 'package:ubereats/controller/provider/resturantProvider/resturantProvider.dart';
import 'package:ubereats/controller/services/locationServices/locationServices.dart';
import 'package:ubereats/model/foodModel.dart';
import 'package:ubereats/model/restaurantModel.dart';
import 'package:ubereats/model/resturantIDnLocationModel.dart';

class ResturantServices {
  static getNearbyResturants(BuildContext context) async {
    Geofire.initialize('Resturants');
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.queryAtLocation(
      currentPosition.latitude,
      currentPosition.longitude,
      20,
    )!
        .listen((event) {
      if (event != null) {
        log('Event is not Null');
        var callback = event['callBack'];
        switch (callback) {
          case Geofire.onKeyEntered:
            ResturantIdnLocationModel model = ResturantIdnLocationModel(
              id: event['key'],
              latitude: event['latitude'],
              longitude: event['longitude'],
            );
            log(model.toJson().toString());
            context.read<ResturantProvider>().addResturants(model.id);
            context.read<ResturantProvider>().addFoods(model.id);
            break;
          case Geofire.onGeoQueryReady:
            ResturantIdnLocationModel model = ResturantIdnLocationModel(
              id: event['key'],
              latitude: event['latitude'],
              longitude: event['longitude'],
            );
            log(model.toJson().toString());

            break;
        }
      }
    });
  }

  static fetchResturantData(String resturantID) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('Resturant').doc(resturantID).get();

      RestaurantModel data = RestaurantModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchFoodData(String resturantID) async {
    List<FoodModel> foodData = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Food')
          .orderBy('uploadTime', descending: true)
          .where('resturantUID', isEqualTo: resturantID)
          .get();
      snapshot.docs.forEach((element) {
        foodData.add(FoodModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return foodData;
  }
}
