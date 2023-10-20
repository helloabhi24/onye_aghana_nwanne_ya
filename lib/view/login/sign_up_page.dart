import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/image_selected_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/const/string_const.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/privcy_policy_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/term_and_condition.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    NetworkController networkController = Get.find();
    final formKey = GlobalKey<FormState>();

    return Obx(
      () => Scaffold(
        appBar: const AppBarWidget(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getheight(context, 0.10),
                    const CustomHeadingText(text: "Sign Up"),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      onChanged: (p0) =>
                          signUpController.isLoading.value = false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return EMPTY_FIRST_NAME;
                        } else if (value.length < 3) {
                          return THREE_FIRST_NAME;
                        }
                        return null;
                      },
                      labelText: "First Name",
                      controller: signUpController.firstNameController,
                    ),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      onChanged: (p0) =>
                          signUpController.isLoading.value = false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return EMPTY_SUR_NAME;
                        } else if (value.length < 3) {
                          return THREE_SUR_NAME;
                        }
                        return null;
                      },
                      labelText: "Surname",
                      controller: signUpController.surNameController,
                    ),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      onChanged: (p0) =>
                          signUpController.isLoading.value = false,
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
                      labelText: "Mobile Number",
                      controller: signUpController.telephoneNumberController,
                    ),
                    getheight(context, 0.020),
                    CustomTextFormField(
                      onChanged: (p0) =>
                          signUpController.isLoading.value = false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return EMPTY_ADMIN_PASSWORD;
                        }
                        return null;
                      },
                      labelText: "Sub Admin Password",
                      controller: signUpController.specialPasswordController,
                    ),
                    getheight(context, 0.020),
                    signUpController.selectedImagePathforSignUp.value.isNotEmpty
                        ? WithImageWidget(
                            fileValue: signUpController
                                .selectedImagePathforSignUp.value,
                            onChangedCamera: () => signUpController
                                .getImageforSignUp(ImageSource.camera),
                            onChangedCancel: () => signUpController
                                .selectedImagePathforSignUp.value = "",
                            onChangedGallery: () => signUpController
                                .getImageforSignUp(ImageSource.gallery),
                          )
                        : WithOutImageWidget(
                            isAnyImage: false,
                            onChangedCamera: () => signUpController
                                .getImageforSignUp(ImageSource.camera),
                            onChangedGallery: () => signUpController
                                .getImageforSignUp(ImageSource.gallery),
                          ),
                    getheight(context, 0.020),
                    Wrap(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: signUpController.isChecked.value,
                              onChanged: (value) async {
                                signUpController.isChecked.value = value!;
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                    text: "By signing up, you agree to our "),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => Get.to(
                                          () => const TermAndConditionPage()),
                                      child: CustomText(
                                        text: "Terms and Conditions",
                                        color: blueColor,
                                      ),
                                    ),
                                    const CustomText(text: " & "),
                                    InkWell(
                                      onTap: () => Get.to(
                                          () => const PrivcyPolicyPage()),
                                      child: CustomText(
                                        text: "Privacy Policy",
                                        color: blueColor,
                                      ),
                                    )
                                  ],
                                ),
                                Visibility(
                                  visible: !signUpController.isChecked.value,
                                  child: Column(
                                    children: [
                                      // getheight(context, 0.001),
                                      CustomText(
                                        text: "Please Check on Box for Proceed",
                                        color: redColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    getheight(context, 0.020),
                    !signUpController.isLoading.value
                        ? CustomButton(
                            text: "Submit",
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (networkController.isInternet.value) {
                                  if (signUpController.isChecked.value) {
                                    await signUpController
                                        .checkValidationOnSignUp();
                                  }
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
                        GestureDetector(
                            onTap: () => Get.off(() => const SingInPage(),
                                transition: Transition.circularReveal),
                            child: CustomText(
                              text: " Login",
                              color: blueColor,
                            ))
                      ],
                    )
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
