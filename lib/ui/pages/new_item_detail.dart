import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/pages/about_page.dart';
import 'package:tourist_guide/ui/pages/photos_page.dart';
import 'package:tourist_guide/ui/pages/reviews_page.dart';
import 'package:tourist_guide/ui/widgets/favorite_button.dart';
import 'package:tourist_guide/utils/network_util.dart';

class NewDetail extends GetView<ItemDetailController> {
  Item item;
  VoidCallback addToFavoriteCallback;
  VoidCallback removeFromFavoriteCallback;
  late bool isFav;
  bool isAttraction;
  ItemDetailController controller = Get.put(ItemDetailController());

  NewDetail(this.item,
      {required this.isAttraction,
      required this.isFav,
      required this.addToFavoriteCallback,
      required this.removeFromFavoriteCallback}) {
    controller.fetchDetails(item.place_id);
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    title: Text(""),
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height / 3,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      title:  top > 71 && top < 91 ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FavoriteButton(
                            isFav: isFav,
                            removeFromFavoriteCallback: () =>
                                {removeFromFavoriteCallback()},
                            addToFavoriteCallback: () =>
                                {addToFavoriteCallback()},
                          ),
                        ),
                      ): Text(""),
                      background: SafeArea(
                          child: Stack(children: <Widget>[
                        Positioned(
                          top: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    NetworkUtil.makeImageUrlFormReference(
                                        item.photo),
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
                            removeFromFavoriteCallback: () =>
                                {removeFromFavoriteCallback()},
                            addToFavoriteCallback: () =>
                                {addToFavoriteCallback()},
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
            )));
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

