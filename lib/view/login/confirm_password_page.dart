import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_up_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class ConfirmPasswordPage extends StatelessWidget {
  final bool? isForget;
  const ConfirmPasswordPage({super.key, required this.isForget});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    NetworkController networkController = Get.find();
    final formKey = GlobalKey<FormState>();

    return Obx(
      () => Scaffold(
        appBar: AppBarWidget(
          actions: [
            TextButton(
                onPressed: () => Get.offAll(() => const SingUpPage()),
                child: Icon(
                  Icons.cancel,
                  color: darkRedColor,
                  size: 30,
                ))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getheight(context, 0.10),
                  const CustomHeadingText(text: "Create Own Password"),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    onChanged: (p0) => signUpController.isLoading.value = false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return EMPTY_PASSWORD;
                      } else if (value.length < 6) {
                        return LENGTH_PASSWORD;
                      }
                      return null;
                    },
                    controller: signUpController.passwordController,
                    icon: GestureDetector(
                      onTap: () {
                        signUpController.isPwdShowConfirm.value =
                            !signUpController.isPwdShowConfirm.value;
                      },
                      child: signUpController.isPwdShowConfirm.value
                          ? const Icon(
                              Icons.no_encryption_gmailerrorred_outlined,
                              size: 20,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                            ),
                    ),
                    isHidden: signUpController.isPwdShowConfirm.value,
                    labelText: "Password",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    onChanged: (p0) => signUpController.isLoading.value = false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return EMPTY_PASSWORD;
                      } else if (value.length < 6) {
                        return LENGTH_PASSWORD;
                      }
                      return null;
                    },
                    controller: signUpController.passwordConfirmController,
                    icon: GestureDetector(
                      onTap: () {
                        signUpController.isPwdShowConfirmAgain.value =
                            !signUpController.isPwdShowConfirmAgain.value;
                      },
                      child: signUpController.isPwdShowConfirmAgain.value
                          ? const Icon(
                              Icons.no_encryption_gmailerrorred_outlined,
                              size: 20,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                            ),
                    ),
                    isHidden: signUpController.isPwdShowConfirmAgain.value,
                    labelText: "Confirm Password",
                  ),
                  getheight(context, 0.020),
                  !signUpController.isLoading.value
                      ? CustomButton(
                          text: "Done",
                          onPressed: () async {
                            if (signUpController.passwordController.text !=
                                signUpController
                                    .passwordConfirmController.text) {
                              customToast("Password is not matched");
                            } else if (formKey.currentState!.validate()) {
                              if (networkController.isInternet.value) {
                                if (isForget ?? false) {
                                  await signUpController.userUpdatePassword();
                                } else {
                                  await signUpController.registrationFinal();
                                }
                              } else {
                                customToast("Please Connect Internet");
                              }
                            }
                          },
                        )
                      : const CustomLoading(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
