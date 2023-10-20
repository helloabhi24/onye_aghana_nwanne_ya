import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_function.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref = Get.put(SharedPref());
    FormController formController = Get.find();
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          TextButton(
              onPressed: () =>
                  CustomFunction().logOutFunction(context, sharedPref),
              child: Icon(
                Icons.login,
                color: appColor,
              )),
          //
        ],
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getheight(context, 0.10),
                const CustomHeadingText(text: "Congratulations"),
                getheight(context, 0.020),
                Column(
                  children: [
                    getheight(context, 0.040),
                    CustomHeadingText(
                        text:
                            "${formController.first_name.value} ${formController.sur_name.value}"),
                    getheight(context, 0.040),
                    CustomText(
                      text: "Welcome to Home Page",
                      color: blueColor,
                    ),
                    getheight(context, 0.040),
                    CustomButtonHome(
                      text: "Home Dashboard",
                      onPressed: () async {
                        await sharedPref.getuserImage();
                        await sharedPref.getuserId();
                        await formController.loadStoredData();
                        await formController.loadSubmitStoredData();
                        Get.offAll(() => const DashboardPage(),
                            transition: Transition.circularReveal);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
