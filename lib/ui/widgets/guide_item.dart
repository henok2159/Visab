
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/ui/pages/guide_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class GuideWidget extends StatelessWidget {
  FavoritesController controller = Get.find<FavoritesController>();
  String name;
  String imageUrl;
  String id;
  int index;
  late bool isFav;
  GuideWidget(this.id, this.name, this.imageUrl,{this.index = -1}){
    isFav = controller.isGuideAlreadyFav(id);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Get.to(() => GuideDetail(index,id,isFav));},
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                  children: <Widget>[
                    Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        )),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image:this.imageUrl
                        ),
                      ),)
                  ]),
            ),
            Text(this.name, overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }
}

/* Expanded(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(this.imageUrl),
              ),
            ),*/