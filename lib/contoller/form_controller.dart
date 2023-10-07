import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onye_aghana_nwanne_ya/api_repo/api_repo_fun.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/model/form_data_model.dart';
import 'package:onye_aghana_nwanne_ya/model/form_model.dart';
import 'package:onye_aghana_nwanne_ya/model/local_data_model.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import 'package:onye_aghana_nwanne_ya/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormController extends GetxController {
  SharedPref sharedPref = Get.put(SharedPref());
  ApiRepo apiRepo = ApiRepo();
  RxList<FormModel> formsList = <FormModel>[].obs;
  RxList<FormDataModel> formsDataList = <FormDataModel>[].obs;

  RxList<LocalDataModel> localDataList = <LocalDataModel>[].obs;

  RxList<FormDataModel> filterFormList = <FormDataModel>[].obs;
  RxBool isLoading = false.obs;

  var date = DateTime.now().obs;

  RxList<String> items = <String>[].obs;

  RxString first_name = "".obs;
  RxString sur_name = "".obs;

  RxMap allData = {}.obs;

  RxString genderValue = "Select Gender".obs;
  RxList gender = ["Select Gender", "Male", "Female"].obs;

  RxString maritualValue = "Select Maritual Status".obs;
  RxList maritual = [
    "Select Maritual Status",
    "Single",
    "Married",
    "Seperated",
    "Widow",
    "Widower"
  ].obs;

  RxList<dynamic> multi = <dynamic>[].obs;

  NetworkController networkController = Get.find();

  late TextEditingController formTextField;
  late TextEditingController firstFormController;
  late TextEditingController middleFormController;
  late TextEditingController surFormController;
  late TextEditingController teleFormController;
  late TextEditingController addressFormController;
  late TextEditingController dobController;
  late TextEditingController pollUnitController;

  RxString va = "".obs;

  RxInt index = 0.obs;
  RxString formsName = "".obs;
  RxList storedApiResponses = [].obs;

  Future forms(String id, bool isLogin) async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id.isNotEmpty ? id : sharedPref.userID.value;
    print("this is data of id");
    print(data);
    try {
      await apiRepo.forms(data).then((value) async {
        if (value["status"] == true) {
          print('list 1');

          try {
            if (value["data"].length == 0) {
              customToast("No Forms Alloted");
            }
          } catch (e) {
            print(e);
          }

          formsList.value = (value["data"] as List)
              .map(
                (e) => FormModel.fromJson(e),
              )
              .toList();
          // print("this is data");
          // print(value["data"]);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('api_responses', json.encode(value["data"]));
          final storedData = prefs.getString('api_responses');
          print(storedData);
          storedApiResponses.value =
              List<Map<String, dynamic>>.from(json.decode(storedData!));
          print("this is stored data");
          print(storedApiResponses);
          print('list 2');
          if (isLogin) {
            Get.off(() => const DashboardPage());
          } else {
            Get.offAll(() => const HomePage(),
                transition: Transition.circularReveal);
          }
          print("this is pip libe");
          print((formsList[0].formData[1].value.split("|")).first.runtimeType);
          emptyOnlineList();
          // print(value["data"]);
          // print("");
          // print(value["data"][0]["form_data"]);
          // try {
          //   formsDataList.value = (value["data"][0]["form_data"] as List)
          //       .map(
          //         (e) => FormDataModel.fromJson(e),
          //       )
          //       .toList();
          // } catch (e) {
          //   print(e);
          // }

          // print("this is data");
          // print(formsDataList);
          // value["data"][0]["form_data"];
          // for (int i = 0; i < formsList.length; i++) {
          //   // print("this is iterate in loop");
          //   // print(value["data"][i]["form_data"]);
          //   // print(formsDataList);
          //   //   formsDataList.value = (value["data"][i]["form_data"] as List)
          //   //       .map(
          //   //         (e) => FormDataModel.fromJson(e),
          //   //       )
          //   //       .toList();
          //   //   print(formsDataList);
          //   //   print("smoething");
          //   // }
          //   try {
          //     formsDataList.addAll((value["data"][i]["form_data"] as List)
          //         .map(
          //           (e) => FormDataModel.fromJson(e),
          //         )
          //         .toList());
          //   } catch (e) {
          //     print(e);
          //   }
          // }
          // // print('list 3');
          // // print(formsDataList[0].value);
          // try {
          //   filterFormList.value = formsDataList
          //       .where(
          //         (e) => e.questionType == "3" || e.questionType == "4",
          //       )
          //       .toList();
          // } catch (e) {
          //   print(e);
          // }
          // print("filter list");
          // for (var i in formsDataList) {
          //   print(i.question);
          // }
          // for (var i in filterFormList) {
          //   print(i.question);
          // }
          // print(formsDataList.length);
          // print(filterFormList.length);
          // items.value = filterFormList[0].value.split("|");
          // print("this is pipe seprator");
          // for (String i in items) {
          //   print(i);
          // }
          await sharedPref.getuserId();
          await sharedPref.getuserImage();
          print("dashBoard called");

          print("length of form list");
          print(formsList.length);
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

  void emptyOnlineList() async {
    final prefs = await SharedPreferences.getInstance();
    print("this is length of online forms");
    print(formsList.length);
    final storedData = prefs.getString('api_responses');
    print(storedData);
    storedApiResponses.value =
        List<Map<String, dynamic>>.from(json.decode(storedData!));
    print("this is data of local ");
    print(storedApiResponses);
    print("this is length of local");
    print(storedApiResponses.length);
    print(storedApiResponses.isEmpty);
  }

  Future<void> loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('local_data');
    print(storedData!.length);
    if (storedData != null) {
      final data = json.decode(storedData);

      localDataList.value = (data as List<dynamic>).map((item) {
        return LocalDataModel.fromJson(item); // Use the JSON constructor
      }).toList();
    }
  }

  Future<void> storeDataLocally(
      Map<dynamic, dynamic> data, bool shouldDeleteAfterUpload) async {
    final localDataModel = LocalDataModel(
        data: data, shouldDeleteAfterUpload: shouldDeleteAfterUpload);
    localDataList.add(localDataModel);

    final prefs = await SharedPreferences.getInstance();
    final encodedData =
        json.encode(localDataList.map((item) => item.toJson()).toList());
    await prefs.setString('local_data', encodedData);
  }

  void addData(String question, dynamic value) {
    Map map = {question: value};
    finalData(map);
  }

  void finalData(Map map) {
    allData.addAll(map);
    print(allData);
  }

  var maskFormatterforCard = MaskTextInputFormatter(
      mask: '04-##-##-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void onInit() async {
    super.onInit();
    formTextField = TextEditingController();
    firstFormController = TextEditingController();
    middleFormController = TextEditingController();
    surFormController = TextEditingController();
    teleFormController = TextEditingController();
    addressFormController = TextEditingController();
    dobController = TextEditingController();
    pollUnitController = TextEditingController();
    // pollUnitController.text = '04';
    await sharedPref.getuserId();
    await sharedPref.getuserImage();
    print("user image ${await sharedPref.getuserImage()}");

    if (sharedPref.userID.isNotEmpty) {
      await forms(sharedPref.userID.value, true);
    }
    emptyOnlineList();
    loadStoredData();
    isLoading.value = false;
  }

  @override
  void dispose() {
    formTextField.dispose();
    firstFormController.dispose();
    middleFormController.dispose();
    surFormController.dispose();
    teleFormController.dispose();
    addressFormController.dispose();
    dobController.dispose();
    pollUnitController.dispose();
    super.dispose();
  }
}
