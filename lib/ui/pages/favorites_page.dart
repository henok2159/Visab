
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/ui/pages/favorite_attractions_section.dart';

import 'favorite_guides_sections.dart';
import 'favorite_hotels_section.dart';

class FavoritesPage extends GetWidget<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(top: 16),
        child: Scaffold(
            appBar: TabBar(
                labelColor: Theme
                    .of(context)
                    .primaryColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w600),
                indicatorColor: Theme
                    .of(context)
                    .primaryColor,
                unselectedLabelColor: Colors.grey.shade500,
                controller: controller.tabController,
                tabs: <Widget>[
                  Tab(text: "Attractions"),
                  Tab(text: "Hotels",),
                  Tab(text: "Tour Guides")
                ]),
            body: TabBarView(
              children: <Widget>[
                FavoriteAttractionsSection(),
                FavoriteHotelsSection(),
                FavoriteTourGuidesSection(),
              ],
              controller: controller.tabController,
            )),
    );
  }

}