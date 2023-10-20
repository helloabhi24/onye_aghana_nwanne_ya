import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';
import '../utils/size_helper.dart';

class CustomFunction {
  Future<dynamic> logOutFunction(BuildContext context, SharedPref sharedPref) {
    FormController formController = Get.find();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Text("Log Out?"),
                  Positioned(
                      top: -10,
                      right: -10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                          alignment: Alignment(1, -1),
                          child: CircleAvatar(
                              maxRadius: 20,
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.cancel, size: 30)),
                        ),
                      ))
                ],
              ),
              content: SizedBox(
                height: Get.height * 0.223,
                width: Get.width * 0.20,
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
                        getwidth(context, 0.020),
                        ElevatedButton(
                            child: const CustomText(text: "Log Out!"),
                            onPressed: () async {
                              if (formController
                                  .userSubmittedDataList.isNotEmpty) {
                                customToast("First Sync Data");
                                Get.back();
                              } else {
                                await sharedPref.removeValues();

                                Get.offAll(() => const SingInPage());
                                formController.firstFormController.clear();
                                formController.middleFormController.clear();
                                formController.surFormController.clear();
                                formController.teleFormController.clear();
                                formController.addressFormController.clear();
                                formController.dobController.clear();
                                formController.pollUnitController.clear();
                                formController.generalController.clear();
                                formController.editDrftList.clear();
                                formController.ohterWholeList.clear();
                                formController.generalController.clear();
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
