import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import '../../custom_widgets/app_bar_widget.dart';

class PrivcyPolicyPage extends StatelessWidget {
  const PrivcyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.reply,
                size: 40,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getheight(context, 0.010),
              const CustomBoldText(text: "Privacy Policy"),
              getheight(context, 0.020),
              const CustomBoldText(text: "Acceptance of Terms"),
              const CustomText(
                  text:
                      "By using this mobile app, you agree to abide by these terms and conditions."),
              getheight(context, 0.010),
              const CustomBoldText(text: "User Responsibilities"),
              const CustomText(
                  text:
                      "Users are responsible for their actions and content posted within the app."),
              getheight(context, 0.010),
              const CustomBoldText(text: "Privacy"),
              const CustomText(
                  text:
                      "We collect and process data as described in our Privacy Policy"),
              getheight(context, 0.010),
              const CustomBoldText(text: "Intellectual Property"),
              const CustomText(
                  text:
                      "All app content and materials are protected by copyright. "),
              getheight(context, 0.010),
              const CustomBoldText(text: "Liability"),
              const CustomText(
                  text:
                      "We are not liable for any damages or losses resulting from app use.")
            ],
          ),
        ),
      ),
    );
  }
}
