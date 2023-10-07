import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';

import '../utils/size_helper.dart';

class CustomFunction {
  Future<dynamic> logOutFunction(BuildContext context, SharedPref sharedPref) {
    return Get.dialog(
        // barrierDismissible: false,
        Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              size: 60,
              color: redColor,
            ),
            getheight(context, 0.020),
            // const Icon(Icons.login, size: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Are you Sure to Log Out?",
              ),
            ),
            Divider(
              color: redColor,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: const CustomText(text: "Log Out!"),
                    onPressed: () {
                      sharedPref.removeValues();
                      Get.offAll(() => const SingInPage());
                    }),
                getwidth(context, 0.020),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(appColor)),
                    child: CustomText(
                      text: "Cancel",
                      color: appColor,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
