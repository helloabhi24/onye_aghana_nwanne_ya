import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/sign_up_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';
import 'package:onye_aghana_nwanne_ya/utils/loading_indicator.dart';
import 'package:onye_aghana_nwanne_ya/utils/size_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/login/confirm_password_page.dart';
import '../../custom_widgets/app_bar_widget.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class VerificationPage extends StatefulWidget {
  final bool? isForget;
  const VerificationPage({super.key, this.isForget});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  SignUpController signUpController = Get.put(SignUpController());
  NetworkController networkController = Get.find();
  late Timer timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getheight(context, 0.10),
              const CustomHeadingText(text: "Verification Code"),
              getheight(context, 0.020),
              CustomText(
                  text:
                      "Please enter the verificatrion code sent to +234 ${Get.arguments}"),
              getheight(context, 0.020),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.14,
                    height: Get.height * 0.06,
                    child: CustomTextFormField(
                      onChanged: (p0) {
                        signUpController.isLoading.value = false;
                        if (p0.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (p0.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      // labelText: "0",
                      controller: signUpController.otpOneController,
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  getwidth(context, 0.040),
                  SizedBox(
                    width: Get.width * 0.14,
                    height: Get.height * 0.06,
                    child: CustomTextFormField(
                      onChanged: (p0) {
                        signUpController.isLoading.value = false;

                        if (p0.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (p0.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: signUpController.otpTwoController,
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  getwidth(context, 0.040),
                  SizedBox(
                    width: Get.width * 0.14,
                    height: Get.height * 0.06,
                    child: CustomTextFormField(
                      onChanged: (p0) {
                        signUpController.isLoading.value = false;

                        if (p0.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (p0.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      controller: signUpController.otpThreeController,
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  getwidth(context, 0.040),
                  SizedBox(
                    width: Get.width * 0.14,
                    height: Get.height * 0.06,
                    child: CustomTextFormField(
                      onChanged: (p0) {
                        signUpController.isLoading.value = false;

                        if (p0.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (p0.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      controller: signUpController.otpFourController,
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  getwidth(context, 0.040),
                  SizedBox(
                    width: Get.width * 0.14,
                    height: Get.height * 0.06,
                    child: CustomTextFormField(
                      onChanged: (p0) {
                        signUpController.isLoading.value = false;

                        if (p0.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (p0.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      controller: signUpController.otpFiveController,
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                      formatter: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              getheight(context, 0.040),
              CustomButton(
                text: "Submit",
                onPressed: () {
                  String otp = signUpController.otpOneController.text +
                      signUpController.otpTwoController.text +
                      signUpController.otpThreeController.text +
                      signUpController.otpFourController.text +
                      signUpController.otpFiveController.text;
                  if (networkController.isInternet.value) {
                    if (otp.length < 5) {
                      customToast("Please Provide valid otp");
                    } else if (otp == signUpController.otpMsg.value) {
                      Get.dialog(AlertDialog(
                        title: CustomBoldText(
                          text: "OTP Verfiy Successfully",
                          color: greenColor,
                        ),
                        content: const CustomText(
                            text: "Proceed for Change Password"),
                        actions: [
                          CustomButton(
                              text: "Proceed",
                              onPressed: () => Get.to(() => ConfirmPasswordPage(
                                  isForget: widget.isForget)))
                        ],
                      ));

                      // Get.to(() => const ConfirmPasswordPage());
                    } else {
                      customToast("Please enter correct otp");
                    }
                  } else {
                    customToast("Please Connect Internet");
                  }
                },
              ),
              getheight(context, 0.10),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(text: "Edit phone number"),
                        TextButton(
                            onPressed: () => Get.back(),
                            // Get.offAll(() => const SingUpPage()),
                            child: Icon(
                              Icons.edit,
                              color: blueColor,
                            ))
                      ],
                    ),
                    const CustomText(text: "Don't receive an OTP"),
                    getheight(context, 0.010),
                    // signUpController.start.value == 0
                    _start == 0
                        ? Obx(
                            () => !signUpController.isResendOtp.value
                                ? TextButton(
                                    onPressed: () async {
                                      if (networkController.isInternet.value) {
                                        signUpController.isSign.value
                                            ? await signUpController.resendOtp()
                                            : await signUpController
                                                .forgetOtp();
                                        setState(() {
                                          _start = 10;
                                          startTimer();
                                        });
                                      } else {
                                        customToast("Please Connect Internet");
                                      }
                                    },
                                    child: CustomText(
                                      text: "Resend OTP",
                                      color: blueColor,
                                    ))
                                : const CustomLoading(),
                          )
                        : CustomButtonText(
                            // text: "${signUpController.start.value}",
                            text: "$_start",
                            color: blueColor,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
