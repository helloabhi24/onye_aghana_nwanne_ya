import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/forget_password_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_up_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    NetworkController networkController = Get.find();
    SignUpController signUpController = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarWidget(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getheight(context, 0.10),
                  const CustomHeadingText(text: "Login"),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    onChanged: (p0) => signUpController.isLoading.value = false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return EMPTY_MOBILE_NUMBER;
                      } else if (value.length < 10) {
                        return VALID_MOBILE_NUMBER;
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    formatter: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.deny(RegExp('^0+'))
                    ],
                    controller: signUpController.loginPhoneController,
                    labelText: "Mobile Number",
                  ),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    onChanged: (p0) => signUpController.isLoading.value = false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return EMPTY_MOBILE_PASSWORD;
                      }
                      return null;
                    },
                    icon: GestureDetector(
                      onTap: () {
                        signUpController.isPwdShowLogin.value =
                            !signUpController.isPwdShowLogin.value;
                      },
                      child: signUpController.isPwdShowLogin.value
                          ? const Icon(
                              Icons.no_encryption_gmailerrorred_outlined,
                              size: 20,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                            ),
                    ),
                    isHidden: signUpController.isPwdShowLogin.value,
                    labelText: "Password",
                    controller: signUpController.loginPasswordController,
                  ),
                  getheight(context, 0.020),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CustomText(text: ""),
                      GestureDetector(
                          onTap: () {
                            signUpController.isSign.value = false;
                            Get.to(() => const ForgetPasswordPage());
                          },
                          child: const CustomText(text: "Forget Password? ")),
                    ],
                  ),
                  getheight(context, 0.040),
                  !signUpController.isLoading.value
                      ? CustomButton(
                          text: "Submit",
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              if (networkController.isInternet.value) {
                                await signUpController.loginToDash();
                              } else {
                                customToast("Please Connect Internet");
                              }
                            }
                          },
                        )
                      : const CustomLoading(),
                  getheight(context, 0.10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: "Don't have an account?"),
                      // getwidth(context, 0.05),
                      GestureDetector(
                          onTap: () {
                            signUpController.isSign.value = true;
                            Get.off(() => const SingUpPage(),
                                transition: Transition.circularReveal);
                          },
                          child: CustomText(
                            text: " Sign Up",
                            color: blueColor,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
