import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ubereatsdriver/utils/colors.dart';
import 'package:ubereatsdriver/view/HistoryScreen/historyScreen.dart';
import 'package:ubereatsdriver/view/accountScreen/accountScreen.dart';
import 'package:ubereatsdriver/view/homeScreen/homeScreen.dart';

void main() => runApp(BottomNavigationBarUberEatsDemo());

class BottomNavigationBarUberEatsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar Demo',
      home: BottomNavigationBarUberEats(),
    );
  }
}

class BottomNavigationBarUberEats extends StatefulWidget {
  const BottomNavigationBarUberEats({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarUberEats> createState() =>
      _BottomNavigationBarUberEatsState();
}

class _BottomNavigationBarUberEatsState
    extends State<BottomNavigationBarUberEats> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //ResturantServices.getNearbyResturants(context);
    });
  }

  List<PersistentTabConfig> _buildScreens() {
    return [
      PersistentTabConfig(
        screen: HomeScreen(),
        item: ItemConfig(
          icon: FaIcon(FontAwesomeIcons.house),
          title: "Home",
          activeForegroundColor: black,
          inactiveForegroundColor: grey,
        ),
      ),
      PersistentTabConfig(
        screen: HistoryScreen(),
        item: ItemConfig(
          icon: FaIcon(FontAwesomeIcons.list),
          title: "History",
          activeForegroundColor: black,
          inactiveForegroundColor: grey,
        ),
      ),
      
      PersistentTabConfig(
        screen: AccountScreen(),
        item: ItemConfig(
          icon: FaIcon(FontAwesomeIcons.person),
          title: "Account",
          activeForegroundColor: black,
          inactiveForegroundColor: grey,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _buildScreens(),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        /*backgroundColor: white,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: white,
        ),
        hideNavigationBarWhenKeyboardShows: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),*/
      ),
    );
  }
}
