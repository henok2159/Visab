import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/controller/bindings/home_binding.dart';
import 'package:tourist_guide/controller/dashboard_controller.dart';
import 'package:tourist_guide/ui/pages/about_us.dart';
import 'package:tourist_guide/ui/pages/account_page.dart';
import 'package:tourist_guide/ui/pages/favorites_page.dart';
import 'package:tourist_guide/ui/pages/home_page.dart';
import 'package:tourist_guide/ui/pages/search_page.dart';
import 'package:tourist_guide/ui/pages/terms_and_condition.dart';
import 'package:tourist_guide/utils/constants.dart';

import 'login.dart';

class NewDashboardPage extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NewDashboardPage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.title.value),
            actions: [
              controller.tabIndex == 0
                  ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                    onTap: () {
                      Get.to(
                            () => SearchPage(),
                      );
                    },
                    child: Icon(Icons.search)),
              )
                  : controller.tabIndex == 2
                  ? PopupMenuButton<String>(
                onSelected:(value)=> choiceAction(value,controller),
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
                  : Text("")
            ],
          ),
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage("VisAb"),
                FavoritesPage(),
                AccountPage(),
                //settings()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Theme.of(context).primaryColorLight,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: Icons.favorite,
                label: 'Favorites',
              ),
              _bottomNavigationBarItem(
                icon: Icons.account_circle_sharp,
                label: 'Me',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  void choiceAction(String choice, DashboardController controller) {
    if (choice == Constants.aboutUs) {
      Get.to(()=>AboutUs());
    }
    else if (choice == Constants.signOut) {
      Get.find<AuthenticationController>().signOut();
      Get.offAll(() => LoginPage());
      controller.dispose();
    }
    else if(choice == Constants.termsAndConditions){
      Get.to(()=>TermsAndCondition());
    }
  }
}
