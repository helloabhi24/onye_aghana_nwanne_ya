import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_function.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/home_page.dart';
import 'package:onye_aghana_nwanne_ya/view/profile/change_password.dart';
import 'package:onye_aghana_nwanne_ya/view/profile/profile_page.dart';

import '../utils/colors.dart';
import '../utils/size_helper.dart';
import '../view/login/sign_in_page.dart';

class CustomPopDown extends StatelessWidget {
  const CustomPopDown({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    SharedPref sharedPref = Get.put(SharedPref());
    NetworkController networkController = Get.find();

    return PopupMenuButton<int>(
      icon: sharedPref.userImage.isNotEmpty
          ? Container(
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10.0,
                  // offset: Offset(1.0, 1.0),
                ),
              ], borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://misoftwaresolutions.com/csdvoters/public/uploads/${sharedPref.userImage.value}",
                  errorWidget: ((context, url, error) => const CircleAvatar(
                        child: Icon(Icons.person),
                      )),
                ),

                // Image.network(
                //   "https://misoftwaresolutions.com/csdvoters/public/uploads/${sharedPref.userImage.value}",
                // )
              ),
            )
          : const CircleAvatar(
              child: Icon(Icons.person),
            ),
      itemBuilder: (context) => [
        // popupmenu item 1
        PopupMenuItem(
          value: 1,
          onTap: () async {
            print("this is sharedPred");
            print(sharedPref.userID.isNotEmpty);
            if (sharedPref.userID.isNotEmpty) {
              if (networkController.isInternet.value) {
                await signUpController.userEdits(sharedPref.userID.value);
              } else {
                customToast("Please Connect to Internet to Update Profile");
              }
            }
          },
          // row has two child icon and text.
          child: Obx(
            () => !signUpController.isLoading.value
                ? Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: appYellowColor,
                      ),
                      getwidth(context, 0.015),
                      CustomText(
                        text: "Update Profile",
                        color: appYellowColor,
                      )
                    ],
                  )
                : const CustomLoading(),
          ),
        ),
        // popupmenu item 2
        PopupMenuItem(
          onTap: () {
            Get.to(() => const ChangePassword());
          },
          value: 2,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: appYellowColor,
              ),
              getwidth(context, 0.015),
              CustomText(
                text: "Change Password",
                color: appYellowColor,
              )
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            CustomFunction().logOutFunction(context, sharedPref);
          },
          value: 3,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(
                Icons.login,
                color: appYellowColor,
              ),
              getwidth(context, 0.015),
              CustomText(
                text: "Log Out",
                color: appYellowColor,
              )
            ],
          ),
        ),
      ],
      offset: Offset(0, 50),
      color: appColor,
      elevation: 5,
    );
  }
}
