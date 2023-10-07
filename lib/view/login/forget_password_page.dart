import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/verification_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../utils/colors.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    NetworkController networkController = Get.find();
    SignUpController signUpController = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getheight(context, 0.10),
                  const CustomHeadingText(text: "Forget Password"),
                  getheight(context, 0.020),
                  CustomTextFormField(
                    onChanged: (p0) => signUpController.isLoading.value = false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return EMPTY_MOBILE_NUMBER;
                      } else if (value.length < 11) {
                        return VALID_MOBILE_NUMBER;
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    formatter: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    controller: signUpController.forgetPasswordController,
                    labelText: "Mobile Number",
                  ),
                  getheight(context, 0.045),
                  !signUpController.isLoading.value
                      ? CustomButton(
                          text: "Continue",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (networkController.isInternet.value) {
                                await signUpController.userResetPassword(true);
                              } else {
                                customToast("Please Connect Internet");
                              }
                            }
                          },
                        )
                      : const CustomLoading(),
                  getheight(context, 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: "Have an account?"),
                      getwidth(context, 0.010),
                      GestureDetector(
                        onTap: () => Get.off(() => const SingInPage(),
                            transition: Transition.circularReveal),
                        child: CustomText(
                          text: "Login",
                          color: blueColor,
                        ),
                      )
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
