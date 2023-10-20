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
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
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
  RxBool isResendOtp = false.obs;

  RxBool isPwdShow = true.obs;
  RxBool isPwdShowLogin = true.obs;
  RxBool isPwdShowConfirm = true.obs;
  RxBool isPwdShowConfirmAgain = true.obs;

  RxBool isChecked = false.obs;
  RxBool isSign = true.obs;

  RxString userID = "".obs;
  RxString firstName = "".obs;
  RxString surName = "".obs;
  RxString userImage = "".obs;
  RxString telephoneNo = "".obs;

  RxString otpMsg = "".obs;
  RxInt start = 15.obs;
  RxString tempUserID = "".obs;

  RxString firstNameProfile = "".obs;
  RxString surNameProfile = "".obs;
  RxString telephoneProfile = "".obs;

  var pollutionExpireDate = DateTime.now().obs;
  var insExpireDate = DateTime.now().obs;

  var selectedImagePathforSignUp = "".obs;
  RxString base64stringforSignUp = "".obs;
  RxList imageListforSignUp = [].obs;

  var selectedImagePathForProfile = "".obs;
  RxString base64stringForProfile = "".obs;
  RxList imageListForProfile = [].obs;

  Future checkValidationOnSignUp() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};
    data["first_name"] = firstNameController.text;
    data["sur_name"] = surNameController.text;
    data["telephone"] = telephoneNumberController.text;
    data["photo"] = base64stringforSignUp.value;
    data["special_password"] = specialPasswordController.text;

    try {
      await apiRepo.checkValidation(data).then((value) async {
        if (value["status"] == true) {
          Get.to(() => const VerificationPage(),
              transition: Transition.circularReveal,
              arguments: telephoneNumberController.text);
          otpMsg.value = value["message"].toString();
        } else {
          // customToast(value["message"]);
          print("this is value dgd");
          try {
            customToast(value["message"]);
          } catch (e) {
            (e);
          }
          customToast(value["message"]['telephone'][0]);
          print("this is value");
          print(value["message"]['telephone'][0]);
        }
      });
    } catch (e) {
      (e);
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
    isResendOtp.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["telephone"] = telephoneNumberController.text;

    print("data");
    print(data);
    try {
      await apiRepo.resendOtp(data).then((value) async {
        if (value["status"] == true) {
          customToast("OTP send successfully");
          otpMsg.value = value["message"].toString();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isResendOtp.value = false;
  }

  Future forgetOtp() async {
    isResendOtp.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["telephone"] = forgetPasswordController.text;
    print("data");
    print(data);
    try {
      await apiRepo.forgetOtp(data).then((value) async {
        if (value["status"] == true) {
          customToast("OTP send successfully");
          otpMsg.value = value["message"].toString();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isResendOtp.value = false;
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
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
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
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isLoading.value = false;
  }

  Future registrationFinal() async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};
    data["first_name"] = firstNameController.text;
    data["sur_name"] = surNameController.text;
    data["telephone"] = telephoneNumberController.text;
    data["photo"] = base64stringforSignUp.value;
    data["special_password"] = specialPasswordController.text;
    data["password"] = passwordController.text;
    data["confirm_password"] = passwordConfirmController.text;
    try {
      await apiRepo.registration(data).then((value) async {
        if (value["status"] == true) {
          await formController.forms(
              value["data"]["id"].toString(), false, true);

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
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
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
          await formController.forms(
              value["data"]["id"].toString(), true, false);

          userID.value = value["data"]["id"].toString();

          sharedPref.setUserId(value["data"]["id"].toString());
          await sharedPref.getuserId();
          await LocalDatabaseHelper.getSubmitteddNote(sharedPref.userID.value);
          sharedPref.setUserImage(value["data"]['photo']).toString();
          await sharedPref.getuserImage();
          print("this is user profile");
          print(sharedPref.userImage.value);
          loginPhoneController.clear();
          loginPasswordController.clear();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
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

          firstNameProfile.value = value["data"]["first_name"].toString();
          surNameProfile.value = value["data"]["sur_name"].toString();
          telephoneProfile.value = value["data"]["telephone"].toString();
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
      (e);
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

    try {
      await apiRepo.userPasswordChange(data).then((value) async {
        if (value["status"] == true) {
          customToast("Password Changed Successfully");
          Get.offAll(() => const DashboardPage(),
              transition: Transition.circularReveal);
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
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
    data["photo"] = base64stringForProfile.value;
    data["special_password"] = specialPasswordController.text;

    try {
      await apiRepo.userUpdateApi(data).then((value) async {
        if (value["status"] == true) {
          customToast("Profile Update Successfully");
          Get.offAll(() => const DashboardPage(),
              transition: Transition.circularReveal);

          sharedPref.setUserImage(value["data"]['photo']).toString();

          await sharedPref.getuserImage();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isLoading.value = false;
  }

  Future getImageforSignUp(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);

      selectedImagePathforSignUp.value = img!.path;

      File imagefile = File(img.path); //convert Path to File

      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforSignUp.value =
          "data:image/jpeg;base64,${base64.encode(imagebytes)}";

      imageListforSignUp.add("base64,${base64stringforSignUp.value}");
    } else {
      // customToast("No Image Selected");
    }
  }

  Future getImageForProfile(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);

      selectedImagePathForProfile.value = img!.path;

      File imagefile = File(img.path); //convert Path to File

      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringForProfile.value =
          "data:image/jpeg;base64,${base64.encode(imagebytes)}";
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
