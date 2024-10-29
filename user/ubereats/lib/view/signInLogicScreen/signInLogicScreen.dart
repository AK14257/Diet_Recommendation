import 'package:flutter/material.dart';
import 'package:ubereats/controller/services/authServices/mobileAuthServices.dart';

class SignInLogicScreen extends StatefulWidget {
  const SignInLogicScreen({super.key});

  @override
  State<SignInLogicScreen> createState() => _SignInLogicScreenState();
}

class _SignInLogicScreenState extends State<SignInLogicScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MobileAuthServices.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
        image: AssetImage(
          'assets/images/splashScreenImage/SplashScreen.png',
        ),
        //width: 2000,
        //height: 3300,
      ),
    );
  }
/*  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity, // Set width to fill the screen horizontally
        height: double.infinity, // Set height to fill the screen vertically
        child: Image(
          image: AssetImage(
            //'assets/images/splashScreenImage/SplashScreen.png',
            'assets/images/categories/alcohol.png',
          ),
          fit: BoxFit.cover, // Fit the image to cover the entire container
        ),
      ),
    );
  }*/
}
