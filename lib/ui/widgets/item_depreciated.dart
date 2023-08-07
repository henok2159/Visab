import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorite_attractions_controller.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/pages/item_detail_page.dart';
import 'package:tourist_guide/ui/widgets/blur_icon.dart';
import 'package:tourist_guide/ui/widgets/name_with_rating.dart';
import 'package:tourist_guide/utils/network_util.dart';

class ItemWidgetOlder extends StatelessWidget {
  FavoritesController controller = Get.find<FavoritesController>();
  Item item;
  Function(Item item) addToFavoriteCallback;
  Function(String itemId) removeFromFavoriteCallback;
  ItemWidgetOlder(this.item,{required this.addToFavoriteCallback,required this.removeFromFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    bool isFav = controller.isItemAlreadyFav(item.place_id);
    return GestureDetector(
      onTap: () {
        //Get.to(() => ItemDetail(item,isFav: isFav, removeFromFavoriteCallback: removeFromFavoriteCallback,addToFavoriteCallback: addToFavoriteCallback,));
      },
      child: Container(
        width: 200, // width of the card view
        margin:
        const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.network(NetworkUtil.makeImageUrlFormReference(item.photo),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap:() {
                    FocusScope.of(context).requestFocus();
                   if(isFav){
                     removeFromFavoriteCallback(item.place_id);
                     isFav = !isFav;
                   }else {
                     addToFavoriteCallback(item);
                     isFav = !isFav;
                   }
                  },
                  child: BlurIcon(
                    icon: Icon(
                      isFav ? Icons.favorite :
                      Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60, // height of the container that contains name and rating
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: NameWithRatingWidget(name : item.name, rating : item.rating, nameColor:  Colors.white, isAttraction: false, ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


