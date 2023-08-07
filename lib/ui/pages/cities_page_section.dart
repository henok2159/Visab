

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/cities_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/data/places_api_service.dart';
import 'package:tourist_guide/models/city.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/city_item.dart';
import 'package:tourist_guide/ui/widgets/item_depreciated.dart';

class CitiesPageSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 24, left: 16),
          alignment: Alignment.centerLeft,
          child: Text("Popular destinations", style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
          ),
        ),
        SizedBox(height: 16,),
        GetX<CitiesController>(
            init: CitiesController(),
            builder: (controller) {
              return Container(
                height: MediaQuery.of(context).size.height / 4.2,
                child: makeWidgetBasedOnState(controller.state.value,MediaQuery.of(context).size.height / 4.2),
              );
            }
        ),
      ],
    );
  }
}

makeWidgetBasedOnState(state.HomePageState s,height){
  CitiesController controller = Get.find<CitiesController>();
  if(s is state.OnError){
    return Center(child: Text("Error while fetching cities"));
  }
  else if(s is state.OnLoading){
    return Center(child: CircularProgressIndicator(),);
  }
  else if( s is state.OnSuccess){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.cities.length,
      itemBuilder: (ctx, i) {
        City city = controller.cities.elementAt(i) as City;
        return CityWidget(city,height);
      },
    );
  }

}

