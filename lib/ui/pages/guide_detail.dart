import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorite_guides_controller.dart';
import 'package:tourist_guide/controller/guides_controller.dart';
import 'package:tourist_guide/models/tour_guide.dart';
import 'package:tourist_guide/ui/widgets/favorite_button.dart';
import 'package:tourist_guide/utils/other_app_launcher.dart';

class GuideDetail extends GetView<GuidesController> {
  final String id;
  final int index;
  bool isFav;

  GuideDetail(this.index, this.id, this.isFav);

  FavoritesGuidesController _guidesController =
      Get.put(FavoritesGuidesController());
  GuidesController controller = Get.put<GuidesController>(GuidesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Guide's detail"),
        ),
        body: index != -1
            ? buildGuideDetail(context,controller.guides.value.elementAt(index))
            : FutureBuilder(
                future: controller.getTourGuide(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occured',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data as TourGuide;
                      return buildGuideDetail(context, data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }));
  }

  Widget buildGuideDetail(BuildContext context, TourGuide tourGuide) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(color: Colors.black12),
          ),
          new Scaffold(
            backgroundColor: Colors.transparent,
            body: new Container(
              child: new Stack(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.center,
                    child: new Padding(
                      padding: new EdgeInsets.only(top: _height / 15),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage:
                                new NetworkImage(tourGuide.imageUrl),
                            radius: _height / 10,
                          ),
                          new SizedBox(
                            height: _height / 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  tourGuide.name,
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 16,),
                                FavoriteButton(
                                    isFav: isFav,
                                    addToFavoriteCallback: () {
                                      _guidesController.addToFavorites(tourGuide);
                                    },
                                    removeFromFavoriteCallback: () {
                                      _guidesController.removeFromFavorites(
                                          tourGuide.tourGuideId);
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: _height / 2.5),
                    child: new Container(
                      color: Colors.white,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.only(top: _height / 25),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, bottom: 32.0),
                                child: Text(tourGuide.descritpion),
                              ),
                              Text(
                                "Contacts",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () => {
                                  OtherAppLauncherService.sendMail(
                                      tourGuide.email)
                                },
                                child: Column(children: [
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.email,
                                          color:
                                              Theme.of(context).primaryColor),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        tourGuide.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ]),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () => {
                                  OtherAppLauncherService.launchCaller(
                                      tourGuide.phone)
                                },
                                child: Column(children: [
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.call,
                                          color:
                                              Theme.of(context).primaryColor),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        tourGuide.phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ]),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Column(children: [
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_city,
                                        color: Theme.of(context).primaryColor),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      tourGuide.city,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
