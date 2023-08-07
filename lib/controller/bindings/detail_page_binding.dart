import 'package:get/get.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';

class DetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ItemDetailController>(ItemDetailController());
  }
}