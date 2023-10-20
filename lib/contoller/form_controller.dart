import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onye_aghana_nwanne_ya/api_repo/api_repo_fun.dart';
import 'package:onye_aghana_nwanne_ya/contoller/network_connectivity.dart';
import 'package:onye_aghana_nwanne_ya/contoller/shared_prefrence_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/loadingIndicator.dart';
import 'package:onye_aghana_nwanne_ya/model/form_data_model.dart';
import 'package:onye_aghana_nwanne_ya/model/form_model.dart';
import 'package:onye_aghana_nwanne_ya/model/get_form_model.dart';
import 'package:onye_aghana_nwanne_ya/model/local_data_model.dart';
import 'package:onye_aghana_nwanne_ya/model/sync_local_data_model.dart';
import 'package:onye_aghana_nwanne_ya/services/local_database_helper.dart';
import 'package:onye_aghana_nwanne_ya/utils/toast.dart';
import 'package:onye_aghana_nwanne_ya/view/dashboard/dashboard_page.dart';
import 'package:onye_aghana_nwanne_ya/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class FormController extends GetxController {
  SharedPref sharedPref = Get.put(SharedPref());
  ApiRepo apiRepo = ApiRepo();
  RxList<FormModel> formsList = <FormModel>[].obs;
  RxList<DataAccordingFormModel> dataAccordingFormsList =
      <DataAccordingFormModel>[].obs;
  RxList<FormDataModel> formsDataList = <FormDataModel>[].obs;

  // List<table> allForms = [];

  RxList<Map<dynamic, dynamic>> saveAndDrftList = <Map<dynamic, dynamic>>[].obs;
  RxList<Map<dynamic, dynamic>> editDrftList = <Map<dynamic, dynamic>>[].obs;
  RxList<Map<dynamic, dynamic>> syncDrftList = <Map<dynamic, dynamic>>[].obs;

  RxList ohterWholeList = [].obs;

  RxList<LocalDataModel> localDataList = <LocalDataModel>[].obs;
  RxList<SyncLocalDataModel> localSubmitDataList = <SyncLocalDataModel>[].obs;

  RxList<SyncLocalDataModel> userSubmitDataList = <SyncLocalDataModel>[].obs;
  RxList<Map<dynamic, dynamic>> userSubmittedDataList =
      <Map<dynamic, dynamic>>[].obs;

  RxList<FormDataModel> filterFormList = <FormDataModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSyncLoading = false.obs;
  RxBool isSubmitLoading = false.obs;

  var date = DateTime.now().obs;
  late Database database;

  RxList<String> items = <String>[].obs;

  RxString first_name = "".obs;
  RxString sur_name = "".obs;

  RxString formID = ''.obs;
  RxString subadminID = ''.obs;
  RxList values = [].obs;
  RxBool isUpload = false.obs;
  RxBool isGetData = false.obs;

  RxList<TextEditingController> generalController =
      <TextEditingController>[].obs;

  RxMap allData = {}.obs;
  RxList<Map<dynamic, dynamic>> allQuestionData = <Map<dynamic, dynamic>>[].obs;
  RxList editedData = [].obs;
  RxList editedSubmitData = [].obs;

  RxString formEditId = "".obs;

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

  Future forms(String id, bool isLogin, bool isReg) async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id.isNotEmpty ? id : sharedPref.userID.value;

    try {
      await apiRepo.forms(data).then((value) async {
        if (value["status"] == true) {
          try {
            if (value["data"].length == 0) {
              customToast("No Forms Alloted");
            }
          } catch (e) {
            (e);
          }

          formsList.value = (value["data"] as List)
              .map(
                (e) => FormModel.fromJson(e),
              )
              .toList();

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('api_responses', json.encode(value["data"]));
          final storedData = prefs.getString('api_responses');

          storedApiResponses.value =
              List<Map<String, dynamic>>.from(json.decode(storedData!));

          if (isLogin) {
            Get.offAll(() => const DashboardPage(),
                transition: Transition.circularReveal);
          }
          if (isReg) {
            Get.offAll(() => const HomePage(),
                transition: Transition.circularReveal);
          }

          // await loadStoredData();
          // await loadSubmitStoredData();

          emptyOnlineList();

          await sharedPref.getuserId();
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

  Future formSubmit(String id, List queValueList, String formid,
      String subadminid, bool isEdit) async {
    isSubmitLoading.value = true;
    showloadingIndicator();
    final Map<String, dynamic> data = <String, dynamic>{};

    data["subadmin_id"] = subadminid;
    data["staff_id"] = sharedPref.userID.value;
    data["form_data_id"] = formid;
    data["first_name"] = firstFormController.text;
    data["middel_name"] = middleFormController.text;
    data["sur_name"] = surFormController.text;
    data["telephone"] = teleFormController.text;
    data["gender"] =
        genderValue.value == "Select Gender" ? "" : genderValue.value;
    data["address"] = addressFormController.text;
    data["maritual_status"] = maritualValue.value == "Select Maritual Status"
        ? ""
        : maritualValue.value;
    data["dob"] = dobController.text;
    data["poll_unit"] = pollUnitController.text;
    data["form_data"] = queValueList;
    print("data");
    print(data);

    try {
      await apiRepo.saves(data).then((value) async {
        if (value["status"] == true) {
          customToast("Data Successfully Uploded");

          isEdit ? LocalDatabaseHelper.deleteNote(formEditId.value) : null;
          forms(sharedPref.userID.value, true, false);
          // Get.offAll(() => const DashboardPage());
          editedData.clear();
          allData.clear();
          firstFormController.clear();
          middleFormController.clear();
          surFormController.clear();
          teleFormController.clear();
          addressFormController.clear();
          dobController.clear();
          pollUnitController.clear();
          generalController.clear();
          editedSubmitData.clear();
          editDrftList.clear();
          ohterWholeList.clear();
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isSubmitLoading.value = false;
    hideLoading();
  }

  Future getDataAccrodingform() async {
    isGetData.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["staff_id"] = sharedPref.userID.value;
    data["form_data_id"] = formID.value;
    print("data");
    print(data);
    try {
      await apiRepo.getformData(data).then((value) async {
        if (value["status"] == true) {
          dataAccordingFormsList.value = (value["data"] as List)
              .map(
                (e) => DataAccordingFormModel.fromJson(e),
              )
              .toList();
          // Get.off(() => const SubmitForm(),
          //     transition: Transition.noTransition, arguments: values);
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isGetData.value = false;
  }

  // List<Map<String, dynamic>> parseInputString(String inputString) {
  //   List<Map<String, dynamic>> jsonList = [];

  //   // Remove square brackets at the beginning and end of the input string
  //   inputString = inputString.substring(1, inputString.length - 1);

  //   // Split the input string into individual question-answer pairs
  //   List<String> pairs = inputString.split('}, ');

  //   for (var pair in pairs) {
  //     // Split each pair into question, type, and value
  //     List<String> parts = pair.split(', ');

  //     Map<String, dynamic> jsonObject = {};

  //     for (var part in parts) {
  //       List<String> keyValue = part.split(': ');
  //       String key = keyValue[0].replaceAll('{', '');
  //       String value = keyValue[1];

  //       // Remove any leading and trailing curly braces
  //       if (value.startsWith('{')) {
  //         value = value.substring(1);
  //       }
  //       if (value.endsWith('}')) {
  //         value = value.substring(0, value.length - 1);
  //       }

  //       // Convert value to dynamic type if possible
  //       dynamic parsedValue = value;

  //       if (value.isNotEmpty) {
  //         if (value == 'true' || value == 'false') {
  //           parsedValue = (value == 'true');
  //         } else if (int.tryParse(value) != null) {
  //           parsedValue = int.parse(value);
  //         }
  //       }

  //       jsonObject[key] = parsedValue;
  //     }

  //     jsonList.add(jsonObject);
  //   }

  //   return jsonList;
  // }

  List<Map<String, dynamic>> parseInputString(String inputString) {
    // Remove the leading and trailing brackets '[ ]'
    if (inputString.startsWith("[") && inputString.endsWith("]")) {
      inputString = inputString.substring(1, inputString.length - 1);
    }

    List<String> segments = inputString.split("}, {");
    List<Map<String, dynamic>> resultList = [];

    for (String segment in segments) {
      segment = segment.replaceAll("{", "").replaceAll("}", "");
      List<String> keyValuePairs = segment.split(", ");

      Map<String, dynamic> map = {};

      for (String pair in keyValuePairs) {
        List<String> parts = pair.split(": ");
        if (parts.length == 2) {
          map[parts[0]] = parts[1];
        }
      }

      resultList.add(map);
    }

    return resultList;
  }

  Future formSync(
      String id,
      String userid,
      String formid,
      String subadminid,
      String firstname,
      String middlename,
      String surname,
      String telephone,
      String gender,
      String address,
      String maritual,
      String dob,
      String pollUnit,
      List formData) async {
    isLoading.value = true;
    final Map<String, dynamic> data = <String, dynamic>{};

    data["subadmin_id"] = subadminid;
    data["staff_id"] = userid;
    data["form_data_id"] = formid;
    data["first_name"] = firstname;
    data["middel_name"] = middlename;
    data["sur_name"] = surname;
    data["telephone"] = telephone;
    data["gender"] = gender == "Select Gender" ? "" : gender;
    data["address"] = address;
    data["maritual_status"] =
        maritual == "Select Maritual Status" ? "" : maritual;
    data["dob"] = dob;
    data["poll_unit"] = pollUnit;
    data["form_data"] = formData;

    try {
      await apiRepo.saves(data).then((value) async {
        if (value["status"] == true) {
          await LocalDatabaseHelper.deleteNote(id);
          await LocalDatabaseHelper.getSubmitteddNote(sharedPref.userID.value);

          // forms(sharedPref.userID.value, true);
          // Get.offAll(() => const DashboardPage());
        } else {
          customToast(value["message"]);
        }
      });
    } catch (e) {
      (e);
    }
    isLoading.value = false;
  }

  void emptyOnlineList() async {
    final prefs = await SharedPreferences.getInstance();

    final storedData = prefs.getString('api_responses');

    if (storedData != null) {
      storedApiResponses.value =
          List<Map<String, dynamic>>.from(json.decode(storedData));
    }
  }

  Future<void> loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('local_data');

    if (storedData != null) {
      final data = json.decode(storedData);

      localDataList.value = (data as List<dynamic>).map((item) {
        return LocalDataModel.fromJson(item); // Use the JSON constructor
      }).toList();
    }
  }

  Future<void> loadSubmitStoredData() async {
    await sharedPref.getuserId();
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('local_submit_data');

    if (storedData != null) {
      final data = json.decode(storedData);

      localSubmitDataList.value = (data as List<dynamic>).map((item) {
        return SyncLocalDataModel.fromJson(item); // Use the JSON constructor
      }).toList();
    }

    await sharedPref.getuserId();

    userSubmitDataList.clear();
    for (var i in localSubmitDataList) {
      if (sharedPref.userID.value == i.userid) {
        userSubmitDataList.add(i);
      }
    }
  }

  syncData() async {
    isSyncLoading.value = true;

    try {
      for (var i in userSubmittedDataList) {
        syncDrftList.clear();
        try {
          await LocalDatabaseHelper.getSingleSyncNote(i['id'].toString());

          var parshwholeData = parseInputString(syncDrftList[0]["wholelist"]);

          await formSync(
              i['id'].toString(),
              sharedPref.userID.value,
              syncDrftList[0]["formid"],
              syncDrftList[0]["subadminid"],
              syncDrftList[0]["firstName"] ?? "",
              syncDrftList[0]["middleName"] ?? "",
              syncDrftList[0]["surName"] ?? "",
              syncDrftList[0]["phone"] ?? "",
              syncDrftList[0]["gender"] ?? "",
              syncDrftList[0]["address"] ?? "",
              syncDrftList[0]["maritalStatus"] ?? "",
              syncDrftList[0]["dob"] ?? "",
              syncDrftList[0]["pollUnit"] ?? "",
              parshwholeData);
        } catch (e) {
          (e);
        }
      }
      customToast("Sync Successfully Done!!");
      await forms(sharedPref.userID.value, true, false);
      // Get.off(() => const DashboardPage());
    } catch (e) {
      (e);
      // customToast("Something is wrong");
    }

    isSyncLoading.value = false;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("local_data");
    localDataList.clear();
  }

  Future<void> storeDataLocally(
      String userId,
      String formID,
      String subadminId,
      Map<dynamic, dynamic> data,
      bool shouldDeleteAfterUpload,
      String formName,
      bool isEdit,
      int id) async {
    await loadStoredData();
    final localDataModel = LocalDataModel(
        id: isEdit ? id : localDataList.length + 1,
        data: data,
        shouldDeleteAfterUpload: shouldDeleteAfterUpload,
        formName: formName,
        userid: userId,
        formid: formID,
        subadminid: subadminId);
    localDataList.add(localDataModel);

    final prefs = await SharedPreferences.getInstance();
    final encodedData =
        json.encode(localDataList.map((item) => item.toJson()).toList());
    await prefs.setString('local_data', encodedData);
    removeSaveData();
    customToast("Data is Saved in Draft");
  }

  Future<void> storeSubmitDataLocally(
      String userId,
      String formID,
      String subadminId,
      Map<dynamic, dynamic> data,
      bool shouldDeleteAfterUpload,
      String formName,
      bool isEdit,
      List wholelist,
      int id) async {
    await loadSubmitStoredData();
    final localDataModel = SyncLocalDataModel(
        id: isEdit ? id : localSubmitDataList.length + 1,
        data: data,
        shouldDeleteAfterUpload: shouldDeleteAfterUpload,
        formName: formName,
        wholelist: wholelist,
        userid: userId,
        formid: formID,
        subadminid: subadminId);
    localSubmitDataList.add(localDataModel);

    final prefs = await SharedPreferences.getInstance();
    final encodedData =
        json.encode(localSubmitDataList.map((item) => item.toJson()).toList());
    await prefs.setString('local_submit_data', encodedData);
    removeSaveData();
    removeEditData();
    customToast("Please connect with internet to sync data");
    await loadSubmitStoredData();
  }

  void addData(String question, dynamic value) {
    Map map = {question: value};
    finalData(map);
  }

  // void addQustionData(String question, dynamic value, String type) {
  //   // Map map = {question: value};
  //   Map map = {"question": question, "type": type, "value": value};

  //   // finalQuestionData(map);
  // }

  // void editData(List<dynamic> itemList, String question, dynamic newValue) {
  //   for (var item in itemList) {
  //     if (item is Map) {
  //       // Check if the map contains the key you want to update
  //       if (item.containsKey(question)) {
  //         // Update the value of the specified key
  //         item[question] = newValue;
  //       }
  //     }
  //   }
  //   editedfinalData(itemList);
  // }

  List updateValue(List dataList, String key, dynamic newValue) {
    for (var i = 0; i < dataList.length; i++) {
      if (dataList[i] is Map && dataList[i].containsKey(key)) {
        dataList[i][key] = newValue;
      }
    }
    editedfinalData(dataList);

    return dataList;
  }

  void editedfinalData(List wholelist) {
    // editedData.addAll(wholelist);
    editedData.clear();
    editedData.addAll(wholelist);
  }

  void finalData(Map map) {
    allData.addAll(map);
  }

  void finalQuestionData(String question, String type, String value) {
    allQuestionData.clear();
    allQuestionData.add(createMap(question, type, value));
  }

  Map<String, dynamic> createMap(String question, String type, String value) {
    return {
      'question': question,
      'type': type,
      'value': value,
    };
  }

  void removeSaveData() {
    allData.clear();
  }

  void removeEditData() {
    editedData.clear();
  }

  int saveDraftCount(List listOfdata, String matchString) {
    int count = 0;
    try {
      for (var i in listOfdata) {
        if (i.formName == matchString && i.userid == sharedPref.userID.value) {
          count++;
        }
      }
    } catch (e) {
      (e);
    }
    return count;
  }

  List? saveDraftList(List listOfdata, String matchString) {
    List filterFormList = [];
    try {
      for (var i in listOfdata) {
        if (i.formName == matchString && i.userid == sharedPref.userID.value) {
          filterFormList.add(i);
        }
      }
    } catch (e) {
      (e);
    }

    return filterFormList;
  }

  removeEntriesWithQuestion(RxList<dynamic> list, String question) {
    return list
        .removeWhere((entry) => entry is Map && entry['question'] == question);
  }

  RxList<dynamic> removeDuplicate(RxList<dynamic> dataList) {
    Set<String> uniqueQuestions = Set<String>();
    RxList<dynamic> uniqueData = RxList();

    for (var item in dataList) {
      if (item is Map && item.containsKey('question')) {
        String question = item['question'];
        if (!uniqueQuestions.contains(question)) {
          uniqueQuestions.add(question);
          uniqueData.add(item);
        }
      }
    }

    return uniqueData;
  }

  void deletOneLocalData(int id) {
    localDataList.removeWhere((item) => item.id == id);
  }

  Future<void> deleteStoredDataById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('local_data');

    if (storedData != null) {
      final data = json.decode(storedData) as List<dynamic>;

      // Find and remove the item with the specified 'id'
      data.removeWhere((item) => item['id'] == id);

      // Encode the updated data and store it back in SharedPreferences
      final updatedData = json.encode(data);
      await prefs.setString('local_data', updatedData);
      await loadStoredData();
    }
  }

  Future<void> deleteSyncDataById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('local_submit_data');

    if (storedData != null) {
      final data = json.decode(storedData) as List<dynamic>;

      // Find and remove the item with the specified 'id'
      data.removeWhere((item) => item['id'] == id);

      // Encode the updated data and store it back in SharedPreferences
      final updatedData = json.encode(data);
      await prefs.setString('local_submit_data', updatedData);
      await loadStoredData();
    }
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

    await sharedPref.getuserId();
    await sharedPref.getuserImage();
    await loadSubmitStoredData();

    if (sharedPref.userID.isNotEmpty) {
      await forms(sharedPref.userID.value, false, false);
      await LocalDatabaseHelper.getSubmitteddNote(sharedPref.userID.value);
    }
    // database = await LocalDatabaseHelper.getDB();
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
