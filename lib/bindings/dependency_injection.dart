import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    // Get.put<SignUpController>(SignUpController(), permanent: true);
    Get.put<FormController>(FormController(), permanent: true);
  }
}
