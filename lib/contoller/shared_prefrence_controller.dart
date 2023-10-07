import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends GetxController {
  RxString userID = "".obs;
  RxString userImage = "".obs;
  RxString tempUserID = "".obs;

  setUserId(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("UserId", userId);
  }

  getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID.value = prefs.getString('UserId') ?? "";

    return userID;
  }

  setTempUserId(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("UserId", userId);
  }

  getTempuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID.value = prefs.getString('UserId') ?? "";

    return userID;
  }

  setUserImage(String userImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("UserImage", userImage);
  }

  getuserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userImage.value = prefs.getString('UserImage') ?? "";

    return userID;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("UserId");
  }

  @override
  void onInit() async {
    super.onInit();
    await getuserId();
    await getuserImage();
  }
}
