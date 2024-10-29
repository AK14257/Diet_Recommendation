import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereats/controller/provider/authProvider/authProvider.dart';
import 'package:ubereats/controller/provider/profileProvider/profileProvider.dart';
import 'package:ubereats/controller/provider/resturantProvider/resturantProvider.dart';
import 'package:ubereats/firebase_options.dart';
import 'package:ubereats/view/signInLogicScreen/signInLogicScreen.dart';
//import 'package:ubereats/view/userRegistrationScreen/userRegistrationScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UberEats());
}

class UberEats extends StatelessWidget {
  const UberEats({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MobileAuthProvider(),
          ),
          ChangeNotifierProvider<ResturantProvider>(
            create: (_) => ResturantProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.blue),
          home: const SignInLogicScreen(),
          //home: UserRegistrationScreen(),
        ),
      );
    });
  }
}
