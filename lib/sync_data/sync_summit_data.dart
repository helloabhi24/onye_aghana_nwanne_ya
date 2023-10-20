import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_card_widget.dart';
import '../../custom_widgets/custome_pop_down.dart';

class SyncSubmitData extends StatelessWidget {
  const SyncSubmitData({super.key});

  @override
  Widget build(BuildContext context) {
    FormController formController = Get.find();
    NetworkController networkController = Get.find();
    return Obx(
      () => Scaffold(
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getheight(context, 0.10),
                GestureDetector(
                    onTap: () {},
                    child: CustomHeadingText(
                        text:
                            "Sync Data(${formController.userSubmittedDataList.length}) ")),
                getheight(context, 0.010),
                SizedBox(
                  height: 500,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: formController.userSubmittedDataList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CustomContainerListDataTile(
                                  title:
                                      "${formController.userSubmittedDataList[index]["firstName"]} ${(formController.userSubmittedDataList[index]["middleName"]) ?? ""} ${(formController.userSubmittedDataList[index]["surName"]) ?? ""}",
                                  subtitle:
                                      "${(formController.userSubmittedDataList[index]["phone"]) ?? ""}",
                                  pollUnit: (formController
                                              .userSubmittedDataList[index]
                                          ["pollUnit"]) ??
                                      "",
                                  dob: (formController
                                              .userSubmittedDataList[index]
                                          ["dob"]) ??
                                      "",
                                  gender: (formController
                                              .userSubmittedDataList[index]
                                          ["gender"]) ??
                                      "",
                                  maritalStatus: (formController
                                              .userSubmittedDataList[index]
                                          ["maritalStatus"]) ??
                                      "",
                                  image: const CircleAvatar(),
                                  isVerified: 0,
                                  isSync: true,
                                  onIconPressed: () {}),
                              getheight(context, 0.010)
                            ],
                          );
                        }),
                  ),
                ),
                getheight(context, 0.020),
                !formController.isSyncLoading.value
                    ? CustomButton(
                        text: "Sync Now",
                        onPressed: () async {
                          networkController.isInternet.value
                              ? formController.syncData()
                              : customToast("Please connect to internet");
                        })
                    : const CustomLoading()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
