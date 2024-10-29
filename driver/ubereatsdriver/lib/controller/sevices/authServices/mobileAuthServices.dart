import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:ubereatsdriver/constants/constant.dart';
import 'package:ubereatsdriver/controller/provider/authProvider/authProvider.dart';
import 'package:ubereatsdriver/controller/sevices/profileServices/profileServices.dart';
import 'package:ubereatsdriver/controller/sevices/pushNotificationServices/pushNotificationServices.dart';
import 'package:ubereatsdriver/view/authScreens/mobileLoginScreen.dart';
import 'package:ubereatsdriver/view/authScreens/otpScreen.dart';
import 'package:ubereatsdriver/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:ubereatsdriver/view/driverRegistrationScreen/driverRegistrationScreen.dart';
import 'package:ubereatsdriver/view/signInLogicScreen/signInLogicScreen.dart';

class MobileAuthServices {
  static checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const mobileLoginScreen()),
          (route) => false);
      return false;
    } else {
      checkUserRegistration(context: context);
    }
  }

  static receiveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (PhoneAuthCredential credentials) {
          log(credentials.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
          throw Exception(exception);
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerficationID(verificationID);
          Navigator.push(
            context,
            PageTransition(
              child: const OTPScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verficationID) {},
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        PageTransition(
          child: const SignInLogicScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static checkUserRegistration({required BuildContext context}) async {
    try {
      bool userIsRegistered = await ProfileServices.checkForRegistration();

      if (userIsRegistered) {
        PushNotificationservices.initializeFCM();
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const BottomNavigationBarUberEats(),
              type: PageTransitionType.rightToLeft),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const DriverRegistrationScreen(),
              type: PageTransitionType.rightToLeft),
          (route) => false,
        );
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
