// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubereats/constants/constant.dart';
import 'package:ubereats/widgets/toastService.dart';

class ImageServices {
  static pickSingleImage({required BuildContext context}) async {
    File? selectedImages;
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = PickedFile!;
    if (filePick != null) {
      selectedImages = File(filePick.path);
      return selectedImages;
    } else {
      ToastService.sendScaffoldAlert(
        msg: 'No Images Selected',
        toastStatus: 'WARNING',
        context: context,
      );
    }
  }

  static uploadImagesToFirebaseStorageGetURL(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesURL = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child('ResturantBannerImages').child(imageName);
      await ref.putFile(File(image.path));
      String imageURL = await ref.getDownloadURL();
      imagesURL.add(imageURL);
    });
    return imagesURL;
  }
}
