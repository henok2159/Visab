

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/home_page_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/ui/pages/attractions_page_section.dart';
import 'package:tourist_guide/ui/pages/hotels_page_section.dart';
import 'package:tourist_guide/ui/pages/cities_page_section.dart';

class HomePage extends StatelessWidget {
  String title;
  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    List<Widget> sectionsList = [CitiesPageSection(),SizedBox(height: 16,),AttractionsPageSection(Get.find<AttractionsController>(tag : "home_page"),"home_page",()=>Get.find<HomePageController>().getData()),SizedBox(height: 16,),HotelsPageSection(Get.find<HotelsController>(tag: "home_page"))];
    //List<Widget> sectionsList = [AttractionsPageSection()];
    var sections = ListView(children: sectionsList,);

    return sections;
  }
}