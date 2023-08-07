import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/pages/about_page.dart';
import 'package:tourist_guide/ui/pages/photos_page.dart';
import 'package:tourist_guide/ui/pages/reviews_page.dart';
import 'package:tourist_guide/ui/widgets/blur_icon.dart';
import 'package:tourist_guide/ui/widgets/favorite_button.dart';
import 'package:tourist_guide/utils/network_util.dart';

class ItemDetail extends GetView<ItemDetailController> {
  Item item;
  VoidCallback addToFavoriteCallback;
  VoidCallback removeFromFavoriteCallback;
  late bool isFav;
  bool isAttraction;
  ItemDetailController controller = Get.put(ItemDetailController());
  ItemDetail(this.item,{required this.isAttraction, required this.isFav, required this.addToFavoriteCallback,required this.removeFromFavoriteCallback}){
    controller.fetchDetails(item.place_id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Hotel"),
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
                        NetworkUtil.makeImageUrlFormReference(item.photo),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child:  FavoriteButton(isFav: isFav,
                removeFromFavoriteCallback: ()=>{removeFromFavoriteCallback()},
                addToFavoriteCallback:  ()=>{addToFavoriteCallback()},
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
                    child: Scaffold(
                        appBar: TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.w600),
                            indicatorColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.grey.shade500,
                            controller: controller.tabController,
                            tabs: <Widget>[
                              Tab(text: "Overview"),
                              Tab(text: "Photos"),
                              Tab(text: "Reviews"),
                            ]),
                        body: TabBarView(
                          children: <Widget>[
                            AboutPage(isAttraction),
                            PhotosPage(),
                            ReviewsPage(),
                          ],
                          controller: controller.tabController,
                        )),
                  ),
                ))
          ],
        ));
  }
}
