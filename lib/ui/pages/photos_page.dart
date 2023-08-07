import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/models/photo.dart';
import 'package:tourist_guide/utils/network_util.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosPage extends GetView<ItemDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailController>(builder: (controller) {
      return makeWidgetBasedOnState(controller.state.value, context);
    });
  }

  makeWidgetBasedOnState(DetailPageState s, BuildContext context) {
    if (s is OnError) {
      return Center(child: Text("Error while fetching data."));
    } else if (s is OnLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (s is OnSuccess) {
      return ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: (s.itemDetail as ItemDetail).photos.length, //todo
        itemBuilder: (ctx, i) {
          Photo photo = (s.itemDetail as ItemDetail).photos.elementAt(i);
          if (i == ((s.itemDetail as ItemDetail).photos.length - 1)) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("No more photos"),
              ),
            );
          } else {
            return Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 1,))),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: NetworkUtil.makeImageUrlFormReference(
                          photo.photo_reference,
                        )),
                  ),
                )
              ],
            );

            /**/
            /*return  Container(
             height: MediaQuery.of(context).size.height/3,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               image: DecorationImage(
                   image: NetworkImage(NetworkUtil.makeImageUrlFormReference(photo.photo_reference),
                   ),
                   fit: BoxFit.cover),
             ),
           );*/
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      );
    }
  }
}
