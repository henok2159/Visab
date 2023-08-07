import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/search_page_controller.dart';
import 'package:tourist_guide/controller/search_page_state.dart';
import 'package:tourist_guide/models/place_search_suggestion.dart';
import 'package:tourist_guide/ui/pages/new_item_detail.dart';
import 'package:tourist_guide/ui/pages/searched_item_detail_page.dart';


class SearchPage extends GetView<SearchPageController> {
  SearchPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GetX<SearchPageController>(
              init: SearchPageController(),
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 32),
                      child: TextField(
                        key: ValueKey("search_field"),
                        controller: controller.searchBarController,
                        textCapitalization: TextCapitalization.words,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search here anything...',
                          suffixIcon: GestureDetector(
                              onTap: ()=>controller.searchBarController.clear(),
                              child: Icon(Icons.clear)),
                          prefixIcon: GestureDetector(
                              onTap: ()=>Get.back(),
                              child: Icon(Icons.arrow_back)),
                        ),
                        onChanged: (value) => controller.searchPlaces(value),
                        // onTap: () => applicationBloc.clearSelectedLocation(),
                      ),
                    ),
                    controller.searchPageState.value == SearchPageState.onResult
                        ?
                    Expanded(
                      child: ListView.builder(
                        key: ValueKey("search_results"),
                          itemCount: controller.searchResults.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              key: ValueKey(index),
                              title: Text(
                                controller.searchResults[index].description,
                              ),
                              onTap: () {
                                PlaceSearch placeSearch = controller
                                    .searchResults.value.elementAt(index);
                                Get.to(() =>
                                    NewDetailForFavorite(placeSearch.placeId,
                                        isAttraction: placeSearch.types.contains("tourist_attraction"),
                                        isFav: false));
                              },
                            );
                          }),
                    )
                        : controller.searchPageState.value ==
                        SearchPageState.loading ? Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 32,),
                        Center(child: Text("Loading..."),),
                      ],
                    ) : Text(""),
                  ],
                );
              }
          )),
    );
  }
}