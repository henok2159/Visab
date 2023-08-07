import 'package:get/get.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationController>(AuthenticationController(), permanent: true);
  }
}