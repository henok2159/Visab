import 'package:flutter/material.dart';
import 'package:tourist_guide/models/city.dart';
import 'package:tourist_guide/ui/pages/new_city_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class CityWidget extends StatelessWidget {
  City city;
  double height;

  CityWidget(this.city, this.height);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(city.name),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NewCityDetailPage(this.city),
            ));
      },
      child: Container(
        width: 200, // width of the card view
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                  )),
                  Center(
                    child: Container(
                      width: 200,
                      height: height,
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: city.imageUrl,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  // height of the container that contains name and rating
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Text(city.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
