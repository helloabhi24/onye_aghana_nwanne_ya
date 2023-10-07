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
                        } else if (value.length < 11) {
                          return VALID_MOBILE_NUMBER;
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      labelText: "Mobile Number",
                      controller: signUpController.telephoneNumberController,
                    ),
                    getheight(context, 0.020),

                    // const CustomTextFormField(
                    //   labelText: "Upload Photo (Optional)",
                    // ),
                    // getheight(context, 0.020),
                    CustomTextFormField(
                      onChanged: (p0) =>
                          signUpController.isLoading.value = false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return EMPTY_ADMIN_PASSWORD;
                        }
                        return null;
                      },
                      // icon: GestureDetector(
                      //   onTap: () {
                      //     signUpController.isPwdShow.value =
                      //         !signUpController.isPwdShow.value;
                      //   },
                      //   child: signUpController.isPwdShow.value
                      //       ? const Icon(
                      //           Icons.no_encryption_gmailerrorred_outlined,
                      //           size: 20,
                      //         )
                      //       : const Icon(
                      //           Icons.remove_red_eye,
                      //           size: 20,
                      //         ),
                      // ),
                      // isHidden: signUpController.isPwdShow.value,
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
                            onChangedCamera: () => signUpController
                                .getImageforSignUp(ImageSource.camera),
                            onChangedGallery: () => signUpController
                                .getImageforSignUp(ImageSource.gallery),
                          ),
                    getheight(context, 0.020),
                    Wrap(
                      children: [
                        const CustomText(
                            text: "By singing up, you agree to our "),
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => const TermAndConditionPage()),
                          child: CustomText(
                            text: "Terms and Conditions",
                            color: blueColor,
                          ),
                        ),
                        const CustomText(text: " & "),
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => const TermAndConditionPage()),
                          child: CustomText(
                            text: "Privacy Policy",
                            color: blueColor,
                          ),
                        )
                      ],
                    ),
                    getheight(context, 0.020),
                    !signUpController.isLoading.value
                        ? CustomButton(
                            text: "Submit",
                            onPressed: () async {
                              // if (signUpController
                              //     .firstNameController.text.isEmpty) {
                              //   customToast("Please Provide First Name");
                              // } else if (signUpController
                              //         .firstNameController.text.length <
                              //     3) {
                              //   customToast(
                              //       "Please Provide at Least 3 Character at First Name");
                              // } else if (signUpController
                              //         .surNameController.text.length <
                              //     3) {
                              //   customToast(
                              //       "Please Provide at Least 3 Character at Sur Name");
                              // } else if (signUpController
                              //     .surNameController.text.isEmpty) {
                              //   customToast("Please Provide Sur Name");
                              // } else if (signUpController
                              //     .telephoneNumberController.text.isEmpty) {
                              //   customToast("Please Provide Mobile Number");
                              // } else if (signUpController
                              //     .specialPasswordController.text.isEmpty) {
                              //   customToast("Please Provide Password");
                              // } else {
                              //   await signUpController
                              //       .checkValidationOnSignUp();
                              // }

                              if (formKey.currentState!.validate()) {
                                if (networkController.isInternet.value) {
                                  await signUpController
                                      .checkValidationOnSignUp();
                                } else {
                                  customToast("Please Connect Internet");
                                }
                              }

                              // Get.to(() => const VerificationPage(),
                              // transition: Transition.circularReveal);
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
