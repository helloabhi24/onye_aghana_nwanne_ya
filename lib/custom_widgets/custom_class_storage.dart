import 'dart:convert';
import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiStorage {
  static const String apiResponseKey = 'api_response_key';
  FormController formController = Get.find();

  // Store API response locally
  static Future<void> storeApiResponse(
      List<Map<String, dynamic>> apiResponses) async {
    final prefs = await SharedPreferences.getInstance();
    final apiResponseString = json.encode(apiResponses);
    await prefs.setString(apiResponseKey, apiResponseString);
  }

  // Parsing the API response
  // final List<Map<String, dynamic>> apiResponses =
  //     formController.formsList; // Your API response data

  // List<YourApiResponseClass> parsedResponses = apiResponses.map((apiResponse) {
  //   final List<Map<String, dynamic>> formModelData =
  //       apiResponse['form_data'] != null
  //           ? List<Map<String, dynamic>>.from(apiResponse['form_data'])
  //           : [];

  //   final List<FormModel> formModels = formModelData
  //       .map((formData) => formData['form_model'] != null
  //           ? List<Map<String, dynamic>>.from(formData['form_model'])
  //               .map((formModelMap) => FormModel.fromJson(formModelMap))
  //               .toList()
  //           : [])
  //       .expand((element) => element)
  //       .toList();

  // Create your ApiResponseClass object and include the formModels
  //   return YourApiResponseClass(
  //     id: apiResponse['id'],
  //     subAdminId: apiResponse['sub_admin_id'],
  //     formName: apiResponse['form_name'],
  //     // Add other fields as needed
  //     formModels: formModels,
  //   );
  // }).toList();

  // Retrieve stored API response
  static Future<List<Map<String, dynamic>>> getStoredApiResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final apiResponseString = prefs.getString(apiResponseKey);
    print(apiResponseString);
    if (apiResponseString != null) {
      final apiResponses = json.decode(apiResponseString) as List;
      return apiResponses.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  // Update stored API response with new data
  static Future<void> updateStoredApiResponse(
      List<Map<String, dynamic>> newData) async {
    final currentData = await getStoredApiResponse();
    currentData.addAll(newData);
    await storeApiResponse(currentData);
  }

  static Future<void> deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("UserId");
  }
}
