

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/models/item.dart';

import 'blur_icon.dart';

class FavoriteButton extends StatefulWidget {

  VoidCallback addToFavoriteCallback;
  VoidCallback removeFromFavoriteCallback;
  bool isFav;
  FavoriteButton({required this.isFav, required this.addToFavoriteCallback,required this.removeFromFavoriteCallback});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    print("Fav Button Build method called....");
    return GestureDetector(
      onTap:() {
        FocusScope.of(context).requestFocus();
        if(widget.isFav){
          widget.removeFromFavoriteCallback();
        }else {
          widget.addToFavoriteCallback();
        }
        setState(() {
          widget.isFav = !widget.isFav;
        });
      },
      child: BlurIcon(
        icon: Icon(
          widget.isFav ? Icons.favorite :
          Icons.favorite_border,
          color:  widget.isFav ? Colors.redAccent : Colors.white,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
