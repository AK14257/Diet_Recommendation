import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ubereats/controller/services/imageServices/imageServices.dart';

class ProfileProvider extends ChangeNotifier {
  File? profileImage;
  String? profileImageURL;

  pickFoodImageFromGallery(BuildContext context) async {
    profileImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url = await ImageServices.uploadImagesToFirebaseStorageGetURL(
      images: [profileImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      profileImageURL = url[0];
      log(profileImageURL!);
    }
    notifyListeners();
  }
}
