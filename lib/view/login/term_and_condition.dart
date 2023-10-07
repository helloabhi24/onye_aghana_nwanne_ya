import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/forget_password_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_up_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class TermAndConditionPage extends StatelessWidget {
  const TermAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: lightAmber.withOpacity(0.1),
      appBar: AppBarWidget(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getheight(context, 0.010),
              CustomBoldText(text: "Terms and Conditons"),
              getheight(context, 0.020),
              CustomBoldText(text: "Acceptance of Terms"),
              CustomText(
                  text:
                      "By using this mobile app, you agree to abide by these terms and conditions."),
              getheight(context, 0.010),
              CustomBoldText(text: "User Responsibilities"),
              CustomText(
                  text:
                      "Users are responsible for their actions and content posted within the app."),
              getheight(context, 0.010),
              CustomBoldText(text: "Privacy"),
              CustomText(
                  text:
                      "We collect and process data as described in our Privacy Policy"),
              getheight(context, 0.010),
              CustomBoldText(text: "Intellectual Property"),
              CustomText(
                  text:
                      "All app content and materials are protected by copyright. "),
              getheight(context, 0.010),
              CustomBoldText(text: "Liability"),
              CustomText(
                  text:
                      "We are not liable for any damages or losses resulting from app use.")
            ],
          ),
        ),
      ),
    );
  }
}
