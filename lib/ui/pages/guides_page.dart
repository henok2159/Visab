import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/guides_controller.dart';
import 'package:tourist_guide/models/tour_guide.dart';
import 'package:tourist_guide/ui/widgets/guide_item.dart';

import 'guide_detail.dart';

class GuidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<GuidesController>(
      init: GuidesController(),
      builder: (GuidesController controller) {
        return Scaffold(
            appBar: AppBar(
              title: new Text(
                "Guides",
                style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: controller.guides.value.length,
                      itemBuilder: (_, index) {
                        TourGuide tourGuide =
                            controller.guides.value.elementAt(index);
                        return GuideWidget(tourGuide.tourGuideId,
                            tourGuide.name, tourGuide.imageUrl,index: index,);
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
