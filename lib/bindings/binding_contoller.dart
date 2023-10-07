import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';

class GetxControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<SharedPref>(() => SharedPref(), fenix: true);
  }
}
