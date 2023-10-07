import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/model/form_model.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import 'package:onye_aghana_nwanne_ya/view/home_page.dart';
import 'package:onye_aghana_nwanne_ya/view/login/sign_in_page.dart';

import '../api_repo/api_repo_fun.dart';
import '../view/login/verification_page.dart';
import '../view/profile/profile_page.dart';

class SignUpController extends GetxController {
  ApiRepo apiRepo = ApiRepo();
  SharedPref sharedPref = Get.put(SharedPref());
  FormController formController = Get.find();

  late TextEditingController firstNameController;
  late TextEditingController surNameController;
  late TextEditingController specialPasswordController;
  late TextEditingController telephoneNumberController;

  late TextEditingController loginPhoneController;
  late TextEditingController loginPasswordController;

  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController newConPasswordController;

  late TextEditingController otpOneController;
  late TextEditingController otpTwoController;
  late TextEditingController otpThreeController;
  late TextEditingController otpFourController;
  late TextEditingController otpFiveController;

  late TextEditingController forgetPasswordController;

  Timer timer = Timer(const Duration(seconds: 1), () {});

  RxList<FormModel> formsList = <FormModel>[].obs;

  RxBool isRcSubmit = false.obs;
  RxBool isPullutionSubmit = false.obs;
  RxBool isInsuranceSubmit = false.obs;

  RxBool isLoading = false.obs;

  RxBool isPwdShow = true.obs;
  RxBool isPwdShowLogin = true.obs;
  RxBool isPwdShowConfirm = true.obs;
  RxBool isPwdShowConfirmAgain = true.obs;

  RxString userID = "".obs;
  RxString firstName = "".obs;
  RxString surName = "".obs;
  RxString userImage = "".obs;
  RxString telephoneNo = "".obs;

  RxString otpMsg = "".obs;
  RxInt start = 15.obs;
  RxString tempUserID = "".obs;

  var pollutionExpireDate = DateTime.now().obs;
  var insExpireDate = DateTime.now().obs;

  var selectedImagePathforSignUp = "".obs;
  RxString base64stringforSignUp = "".obs;
  RxList imageListforSignUp = [].obs;

  var selectedImagePathForOtherProof = "".obs;
  RxString base64stringForOtherProof = "".obs;
  RxList imageListForOtherProof = [].obs;

  Future checkValidationOnSignUp() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["driver_id"] = 01;
    data["first_name"] = firstNameController.text;
    data["sur_name"] = surNameController.text;
    data["telephone"] = telephoneNumberController.text;
    // data["photo"] = imageListforSignUp.toString();
    data["photo"] = base64stringforSignUp.value;

    data["special_password"] = specialPasswordController.text;

    print("this is value of clothing");
    print(data);
    try {
      await apiRepo.checkValidation(data).then((value) async {
        if (value["status"] == true) {
          // await resendOtp();
          Get.to(() => const VerificationPage(),
              transition: Transition.circularReveal,
              arguments: telephoneNumberController.text);
          otpMsg.value = value["message"].toString();

          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value = start.value - 1;
        }
      },
    );
  }

  Future resendOtp() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["telephone"] = telephoneNumberController.text;

    try {
      await apiRepo.resendOtp(data).then((value) async {
        if (value["status"] == true) {
          customToast("OTP send successfully");
          // Get.to(() => const VerificationPage(),
          //     transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future userResetPassword(bool isForget) async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["phone"] = forgetPasswordController.text;

    try {
      await apiRepo.userResetPassword(data).then((value) async {
        if (value["status"] == true) {
          customToast("OTP send successfully");
          Get.to(
              () => VerificationPage(
                    isForget: isForget,
                  ),
              arguments: forgetPasswordController.text);
          otpMsg.value = value["message"].toString();
          tempUserID.value = value["data"]["id"].toString();
          // sharedPref.setTempUserId(value["data"]["id"].toString());
          // sharedPref.setUserImage(value["data"]['photo']).toString();

          // Get.to(() => const VerificationPage(),
          //     transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future userUpdatePassword() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = tempUserID.value;
    data["newpassword"] = passwordController.text;
    data["confirmpassword"] = passwordConfirmController.text;
    print("this is data of user Upate ");
    print(data);

    try {
      await apiRepo.userUpdatePassword(data).then((value) async {
        if (value["status"] == true) {
          // customToast("OTP send successfully");
          customToast(value["message"]);
          Get.offAll(() => const SingInPage());
          // await formController.forms(value["data"]["id"].toString(), true);
          // await forms(value["data"]["id"].toString(), false);
          // sharedPref.setUserId(value["data"]["id"].toString());
          // sharedPref.setUserImage(value["data"]['photo']).toString();
          // firstName.value = value["data"]['first_name'].toString();
          // surName.value = value["data"]['sur_name'].toString();
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  // Future forms(String id, bool isLogin) async {
  //   isLoading.value = true;
  //   final Map<String, dynamic> data = <String, dynamic>{};

  //   data["id"] = id.isNotEmpty ? id : sharedPref.userID.value;
  //   print("this is data of id");
  //   print(data);
  //   try {
  //     await apiRepo.forms(data).then((value) async {
  //       if (value["status"] == true) {
  //         formsList.value = (value["data"] as List)
  //             .map(
  //               (e) => FormModel.fromJson(e),
  //             )
  //             .toList();
  //         print("dashBoard called");
  //         if (isLogin) {
  //           Get.off(() => const DashboardPage());
  //         } else {
  //           Get.offAll(() => const HomePage(),
  //               transition: Transition.circularReveal);
  //         }

  //         print("length of form list");
  //         print(formsList.length);
  //         // Get.to(() => const VerificationPage(),
  //         //     transition: Transition.circularReveal);
  //         // customToast(
  //         //     "You Successfully Submitted All Information, Please Contact Admin for Password");
  //         // Get.offAll(
  //         //   SignInWidget(),
  //         // );
  //       } else {
  //         customToast(value["message"]);
  //       }
  //     });
  //   } catch (e) {
  //     // print(e);
  //   }
  //   isLoading.value = false;
  // }

  Future registrationFinal() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["driver_id"] = 01;
    data["first_name"] = firstNameController.text;
    data["sur_name"] = surNameController.text;
    data["telephone"] = telephoneNumberController.text;
    // data["photo"] = imageListforSignUp.toString();
    data["photo"] = base64stringforSignUp.value;

    data["special_password"] = specialPasswordController.text;
    data["password"] = passwordController.text;
    data["confirm_password"] = passwordConfirmController.text;

    print("this is value of clothing");
    print(data);
    // print(base64stringforSignUp.runtimeType);
    try {
      await apiRepo.registration(data).then((value) async {
        if (value["status"] == true) {
          // Get.offAll(() => const HomePage());
          await formController.forms(value["data"]["id"].toString(), false);
          // await forms(value["data"]["id"].toString(), false);
          print("this is user name");
          print(value["data"]['first_name'].toString());
          firstName.value = value["data"]['first_name'].toString();
          surName.value = value["data"]['sur_name'].toString();
          print("ths is first name value");
          formController.first_name.value =
              value["data"]['first_name'].toString();
          formController.sur_name.value = value["data"]['sur_name'].toString();
          print(firstName.value);
          sharedPref.setUserId(value["data"]["id"].toString());
          sharedPref.setUserImage(value["data"]['photo']).toString();

          // Get.to(() => const VerificationPage(),
          //     transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future loginToDash() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["telephone"] = loginPhoneController.text;
    data["password"] = loginPasswordController.text;

    try {
      await apiRepo.login(data).then((value) async {
        if (value["status"] == true) {
          // Get.offAll(() => const DashboardPage(),
          // sharedPref.setUserId(value["data"]["id"].toString());

          // sharedPref.setUserImage(value["data"]['photo']).toString();
          //     transition: Transition.circularReveal);
          await formController.forms(value["data"]["id"].toString(), true);
          // await forms(value["data"]["id"].toString(), true);
          print('This si value of something');
          userID.value = value["data"]["id"].toString();
          sharedPref.setUserId(value["data"]["id"].toString());
          sharedPref.setUserImage(value["data"]['photo']).toString();
          await sharedPref.getuserId();
          await sharedPref.getuserImage();
          print("this is value of image ");
          print(sharedPref.userImage.value);
          // Get.offAll(() => const DashboardPage(),
          //     transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future userEdits(String userId) async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = userId;

    try {
      await apiRepo.userEditApi(data).then((value) async {
        if (value["status"] == true) {
          Get.to(() => const ProfilePage(),
              transition: Transition.circularReveal);

          // firstName.value = value["data"]["first_name"].toString();
          // surName.value = value["data"]["sur_name"].toString();
          // telephoneNo.value = value["data"]["telephone"].toString();
          // userImage.value = value["data"]["photo"].toString();
          firstNameController.text = value["data"]["first_name"].toString();
          surNameController.text = value["data"]["sur_name"].toString();
          telephoneNumberController.text =
              value["data"]["telephone"].toString();
          userImage.value = value["data"]["photo"].toString();
          specialPasswordController.text =
              value["data"]["special_password"].toString();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future userPasswordChanges() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = sharedPref.userID.value;
    data["oldpassword"] = oldPasswordController.text;
    data["newpassword"] = newPasswordController.text;
    data["confirmpassword"] = newConPasswordController.text;

    print("this is data of password change");
    print(data);

    try {
      await apiRepo.userPasswordChange(data).then((value) async {
        if (value["status"] == true) {
          customToast("Password Changed Successfully");
          Get.offAll(() => const DashboardPage(),
              transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future userUpdates() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = sharedPref.userID.value;
    data["first_name"] = firstNameController.text;
    data["sur_name"] = surNameController.text;
    data["telephone"] = telephoneNumberController.text;
    data["photo"] = base64stringforSignUp.value;
    data["special_password"] = specialPasswordController.text;
    print("this is data of updates");
    print(data);
    try {
      await apiRepo.userUpdateApi(data).then((value) async {
        if (value["status"] == true) {
          customToast("Profile Update Successfully");
          Get.offAll(() => const DashboardPage(),
              transition: Transition.circularReveal);
          // customToast(
          //     "You Successfully Submitted All Information, Please Contact Admin for Password");
          // Get.offAll(
          //   SignInWidget(),
          // );
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      // print(e);
    }
    isLoading.value = false;
  }

  Future getImageforSignUp(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);

      // pathName.value = pickeImage.name;

      // selectedImagePath.value = await img!.path;
      selectedImagePathforSignUp.value = img!.path;

      // File imagefile = File(selectedImagePath.value); //convert Path to File
      File imagefile = File(img.path); //convert Path to File

      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforSignUp.value =
          "data:image/jpeg;base64,${base64.encode(imagebytes)}";

      imageListforSignUp.add("base64,${base64stringforSignUp.value}");
    } else {
      // customToast("No Image Selected");
    }
  }

  getCroppedImage(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        maxHeight: 150,
        maxWidth: 150,
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 2));
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  @override
  void onInit() async {
    super.onInit();
    firstNameController = TextEditingController();
    surNameController = TextEditingController();
    specialPasswordController = TextEditingController();
    telephoneNumberController = TextEditingController();

    loginPhoneController = TextEditingController();
    loginPasswordController = TextEditingController();

    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();

    otpOneController = TextEditingController();
    otpTwoController = TextEditingController();
    otpThreeController = TextEditingController();
    otpFourController = TextEditingController();
    otpFiveController = TextEditingController();

    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newConPasswordController = TextEditingController();

    forgetPasswordController = TextEditingController();
    if (sharedPref.userID.isNotEmpty) {
      await sharedPref.getuserId();
      await sharedPref.getuserImage();
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    surNameController.dispose();
    specialPasswordController.dispose();
    telephoneNumberController.dispose();

    loginPhoneController.dispose();
    loginPasswordController.dispose();

    passwordController.dispose();
    passwordConfirmController.dispose();

    otpOneController.dispose();
    otpTwoController.dispose();
    otpThreeController.dispose();
    otpFourController.dispose();
    otpFiveController.dispose();

    oldPasswordController.dispose();
    newConPasswordController.dispose();
    newPasswordController.dispose();
    forgetPasswordController.dispose();
  }
}
