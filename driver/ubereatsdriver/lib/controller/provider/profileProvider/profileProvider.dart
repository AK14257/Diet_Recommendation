import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubereatsdriver/controller/sevices/imageServices/imageServices.dart';
import 'package:ubereatsdriver/model/driverModel/driverModel.dart';

class ProfileProvider extends ChangeNotifier {
  DriverModel? driverProfile;
  File? profileImage;
  String? profileImageURL;

  pickFoodImageFromGallery(BuildContext context) async {
    profileImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url = await ImageServices.uploadImagesToFirebaseStorageNGetURL(
      images: [profileImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      profileImageURL = url[0];
      log(profileImageURL!);
    }
    notifyListeners();
  }

  updateDriverProfile() async {}
}
