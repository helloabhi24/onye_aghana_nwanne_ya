import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_syn_button.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_form_field.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custome_pop_down.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import '../../custom_widgets/app_bar_widget.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    NetworkController networkController = Get.find();
    final formKey = GlobalKey<FormState>();

    return Obx(
      () => Scaffold(
        appBar: const AppBarWidget(
          actions: [CustomSyncButton(), CustomPopDown()],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getheight(context, 0.10),
                    const CustomHeadingText(text: "Change Password"),
                    getheight(context, 0.020),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return OLD_PASSWORD;
                        } else if (value.length < 6) {
                          return OLD_SIX_PASSWORD;
                        }
                        return null;
                      },
                      controller: signUpController.oldPasswordController,
                      labelText: "Old Password",
                    ),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return NEW_PASSWORD;
                        } else if (value.length < 6) {
                          return LENGTH_PASSWORD;
                        }
                        return null;
                      },
                      controller: signUpController.newPasswordController,
                      labelText: "New Password",
                    ),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return CON_PASSWORD;
                        } else if (value.length < 6) {
                          return LENGTH_PASSWORD;
                        }
                        return null;
                      },
                      controller: signUpController.newConPasswordController,
                      labelText: "Confirm New Password",
                    ),
                    getheight(context, 0.020),
                    !signUpController.isLoading.value
                        ? CustomButton(
                            text: "Submit",
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (signUpController
                                        .newPasswordController.text ==
                                    signUpController
                                        .newConPasswordController.text) {
                                  if (networkController.isInternet.value) {
                                    await signUpController
                                        .userPasswordChanges();
                                  } else {
                                    customToast(
                                        "Please Connect to Internet to Submit");
                                  }
                                } else {
                                  customToast("Password Not Matched");
                                }
                              }
                            })
                        : const CustomLoading(),
                    getheight(context, 0.060),
                    const CustomText(text: "Current Application"),
                    getheight(context, 0.010),
                    const CustomText(text: "Version"),
                    getheight(context, 0.010),
                    const CustomText(text: "0.0.1")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
