import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubereatsdriver/constants/constant.dart';
import 'package:ubereatsdriver/model/driverModel/driverModel.dart';
import 'package:ubereatsdriver/view/signInLogicScreen/signInLogicScreen.dart';
import 'package:ubereatsdriver/widgets/toastService.dart';

class ProfileServices {
  static registerDriver(DriverModel driverData, BuildContext context) {
    realTimeDatabaseRef
        .child('Driver/${auth.currentUser!.uid}')
        .set(driverData.toMap())
        .then((onValue) {
      ToastService.sendScaffoldAlert(
        msg: 'Registered Successfully',
        toastStatus: 'Success',
        context: context,
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: SignInLogicScreen(), type: PageTransitionType.rightToLeft),
          (route) => false);
    }).onError((error, StackTrace) {
      ToastService.sendScaffoldAlert(
        msg: 'Opps! Error getting Registered',
        toastStatus: 'ERROR',
        context: context,
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: SignInLogicScreen(), type: PageTransitionType.rightToLeft),
          (route) => false);
    });
  }

  static Future<bool> checkForRegistration() async {
    try {
      final snapshot = await realTimeDatabaseRef
          .child('Driver/${auth.currentUser!.uid}')
          .get();
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
