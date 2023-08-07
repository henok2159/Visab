import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/pages/new_item_detail.dart';
import 'package:tourist_guide/ui/widgets/favorite_button.dart';
import 'package:tourist_guide/utils/network_util.dart';
import 'package:transparent_image/transparent_image.dart';

import 'name_with_rating.dart';

class ItemWidget extends StatefulWidget {
  Item item;
  bool isAttraction;
  Function(Item item) addToFavoriteCallback;
  Function(String itemId) removeFromFavoriteCallback;
  late bool isFav;
  double height;
  double width;

  ItemWidget(this.item,
      {required this.height,
      required this.width,
      required this.isAttraction,
      required this.addToFavoriteCallback,
      required this.removeFromFavoriteCallback}) {
    isFav = Get.find<FavoritesController>().isItemAlreadyFav(item.place_id);
  }

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key : ValueKey(widget.item.name),
      onTap: () {
        Get.to(() => NewDetail(
              widget.item,
              isAttraction: widget.isAttraction,
              isFav: widget.isFav,
              removeFromFavoriteCallback: () {
                //Get.to(() => ItemDetail(widget.item, isAttraction: widget.isAttraction, isFav:  widget.isFav, removeFromFavoriteCallback: (){
                widget.removeFromFavoriteCallback(widget.item.place_id);
                setState(() {
                  widget.isFav = !widget.isFav;
                });
              },
              addToFavoriteCallback: () {
                widget.addToFavoriteCallback(widget.item);
                setState(() {
                  widget.isFav = !widget.isFav;
                });
              },
            ));
        //Get.to(()=> SliverApp());
      },
      child: Container(
        width: widget.width, // width of the card view
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: <Widget>[
              Stack(children: <Widget>[
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                )),
                Center(
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: NetworkUtil.makeImageUrlFormReference(
                        widget.item.photo,
                      ),
                    ),
                  ),
                )
              ]),
              Positioned(
                top: 8,
                right: 8,
                child: FavoriteButton(
                  isFav: widget.isFav,
                  removeFromFavoriteCallback: () {
                    widget.removeFromFavoriteCallback(widget.item.place_id);
                    widget.isFav = !widget.isFav;
                  },
                  addToFavoriteCallback: () {
                    widget.addToFavoriteCallback(widget.item);
                    widget.isFav = !widget.isFav;
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  // height of the container that contains name and rating
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: NameWithRatingWidget(
                    name: widget.item.name,
                    rating: widget.item.rating,
                    nameColor: Colors.white,
                    isAttraction: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
