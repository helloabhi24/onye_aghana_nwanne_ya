import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const AppBarWidget({super.key, this.actions});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref = Get.put(SharedPref());
    FormController formController = Get.find();
    return AppBar(
      actions: actions,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          elevation: 15,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: GestureDetector(
            onTap: () async {
              if (sharedPref.userID.value.isNotEmpty) {
                Get.offAll(() => const DashboardPage(),
                    transition: Transition.noTransition);
              }
              formController.firstFormController.clear();
              formController.middleFormController.clear();
              formController.surFormController.clear();
              formController.teleFormController.clear();
              formController.addressFormController.clear();
              formController.dobController.clear();
              formController.pollUnitController.clear();
              formController.generalController.clear();
              formController.allData.clear();
              formController.editedData.clear();
              formController.generalController.clear();
              formController.editDrftList.clear();
              formController.ohterWholeList.clear();
              formController.generalController.clear();
            },
            child: Container(
              height: 100,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Image.asset(
                'assets/images/logo.png',
                // height: Get.height * 0.20,
                // width: Get.width * 0.20,
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: <Color>[darkAmber, lightAmber, darkAmber]),
        ),
      ),
    );
  }
}
