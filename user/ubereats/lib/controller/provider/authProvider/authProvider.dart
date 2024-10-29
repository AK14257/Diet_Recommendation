import 'package:flutter/material.dart';

class MobileAuthProvider extends ChangeNotifier {
  String? mobileNumber;
  String? verificationID;
  updateVerficationID(String verfication) {
    verificationID = verfication;
    notifyListeners();
  }

  updatemobileNumber(String number) {
    mobileNumber = number;
    notifyListeners();
  }
}
