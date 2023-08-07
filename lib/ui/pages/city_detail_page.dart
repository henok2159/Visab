

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/cities_detail_controller.dart';
import 'package:tourist_guide/controller/dashboard_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/city.dart';
import 'package:tourist_guide/ui/widgets/description_text.dart';

import 'attractions_page_section.dart';
import 'hotels_page_section.dart';

class CityDetailPage extends StatelessWidget {

  DashboardController controller = Get.find<DashboardController>();
  City city;
  late CityDetailController detailController;
  CityDetailPage(this.city){
    print("City hashcode inside CityDetailPage : ${city.hashCode}");
    detailController = Get.put<CityDetailController>( CityDetailController(city), tag: city.cityId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("City's detail"),
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
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                       city.imageUrl,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  // the height of overview, photo and Reviews tab from the bottom
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    child: ListView(
                      children: [makeDescriptionWidget(context), AttractionsPageSection(detailController.attractionsController, city.cityId,()=>detailController.getData()),SizedBox(height: 16,),HotelsPageSection(detailController.hotelsController)],
                    ),
                  ),
                ))
          ],
        ));
  }


  Widget makeDescriptionWidget(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [Text("Description",style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87),),SizedBox(height: 8,),Padding(
          padding: const EdgeInsets.only( left : 8.0, bottom: 8.0),
          child: CustomExpandableTextWidget(this.city.description),
        ),],),
    );
  }
  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

}
