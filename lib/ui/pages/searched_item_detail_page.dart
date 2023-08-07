import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/controller/search_page_controller.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/ui/pages/about_page.dart';
import 'package:tourist_guide/ui/pages/photos_page.dart';
import 'package:tourist_guide/ui/pages/reviews_page.dart';
import 'package:tourist_guide/ui/widgets/favorite_button.dart';
import 'package:tourist_guide/utils/network_util.dart';

class NewDetailForFavorite extends GetView<ItemDetailController> {
  String id;
  late bool isFav;
  bool isAttraction;
  late ItemDetailController controller ;
  late ItemDetail itemDetail;

  NewDetailForFavorite(
    this.id, {
    required this.isAttraction,
    required this.isFav,
  }) {
    controller = Get.put(ItemDetailController(placeId: id));
    print("place id inside DetailforFavorite page");
    controller.fetchDetails(id);
  }

  @override
  Widget build(BuildContext context) {
    SearchPageController searchPageController =
        Get.find<SearchPageController>();
    var top = 0.0;
    return Obx(() {
      return Scaffold(
          body: controller.state.value is OnSuccess
              ? NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                          title: Text(""),
                          pinned: true,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 3,
                          flexibleSpace: LayoutBuilder(builder:
                              (BuildContext context,
                                  BoxConstraints constraints) {
                            top = constraints.biggest.height;
                            return FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              title: top > 71 && top < 91
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: FavoriteButton(
                                          isFav: isFav,
                                          removeFromFavoriteCallback: () {
                                            this.itemDetail =
                                                controller.itemDetail;
                                            searchPageController
                                                .removeFromFavorites(itemDetail
                                                    .photos[0].photo_reference);
                                          },
                                          addToFavoriteCallback: () => {
                                            searchPageController.addToFavorites(
                                                Item(
                                                    this.itemDetail.name,
                                                    this.itemDetail.place_id,
                                                    itemDetail.rating,
                                                    itemDetail.photos[0]
                                                        .photo_reference))
                                          },
                                        ),
                                      ),
                                    )
                                  : Text(""),
                              background: SafeArea(
                                  child: Stack(children: <Widget>[
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            NetworkUtil
                                                .makeImageUrlFormReference(
                                                    controller
                                                        .itemDetail
                                                        .photos[0]
                                                        .photo_reference),
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: FavoriteButton(
                                    isFav: isFav,
                                    removeFromFavoriteCallback: () {
                                      this.itemDetail = controller.itemDetail;
                                      searchPageController.removeFromFavorites(
                                          itemDetail.photos[0].photo_reference);
                                    },
                                    addToFavoriteCallback: () => {
                                      searchPageController.addToFavorites(Item(
                                          this.itemDetail.name,
                                          this.itemDetail.place_id,
                                          itemDetail.rating,
                                          itemDetail.photos[0].photo_reference))
                                    },
                                  ),
                                ),
                              ])),
                            );
                          })),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                                labelColor: Theme.of(context).primaryColor,
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
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
                          ))
                    ];
                  },
                  body: TabBarView(
                    controller: controller.tabController,
                    children: <Widget>[
                      AboutPage(isAttraction),
                      PhotosPage(),
                      ReviewsPage(),
                    ],
                  ))
              : Center(child: Text("Fetching")));
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
