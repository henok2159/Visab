import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/cities_detail_controller.dart';
import 'package:tourist_guide/controller/dashboard_controller.dart';
import 'package:tourist_guide/models/city.dart';
import 'package:tourist_guide/ui/widgets/description_text.dart';
import 'package:tourist_guide/utils/network_util.dart';
import 'attractions_page_section.dart';
import 'hotels_page_section.dart';

class NewCityDetailPage extends StatelessWidget {
  DashboardController controller = Get.find<DashboardController>();

  City city;
  late CityDetailController detailController;

  NewCityDetailPage(this.city) {
    print("City hashcode inside CityDetailPage : ${city.hashCode}");
    detailController = Get.put<CityDetailController>(
        CityDetailController(city), tag: city.cityId);
  }

  Widget build(BuildContext context) {
    var top = 0.0;
    return WillPopScope(

      onWillPop: () {
        controller.changeTabIndex(0);
        print("Tab index : ${controller.tabIndex}");
        return Future.value(true);
        },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Theme.of(context).primaryColorLight,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (value) => controller.changeTabIndex(value,true),
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
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    pinned: true,
                    expandedHeight: MediaQuery
                        .of(context)
                        .size
                        .height / 3,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        titlePadding: EdgeInsets.only(left: 0.0),
                        title: top > 71 && top < 100? Padding(
                          padding: const EdgeInsets.only(left: 64.0,bottom: 16),
                          child: Text(this.city.name),
                        ) : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left : 10.0, top: 8.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            this.city.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        background: SafeArea(
                            child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 3,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      city.imageUrl,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            )),
                      );
                    })),
              ];
            },
            body: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              // the height of overview, photo and Reviews tab from the bottom
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: ListView(
                  children: [
                    makeDescriptionWidget(context),
                    AttractionsPageSection(
                        detailController.attractionsController, city.cityId, ()=>detailController.getData()),
                    SizedBox(height: 16,),
                    HotelsPageSection(detailController.hotelsController)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget makeDescriptionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [Text("Description", style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87),), SizedBox(height: 8,), Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: CustomExpandableTextWidget(this.city.description),
        ),
        ],),
    );
  }
  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}