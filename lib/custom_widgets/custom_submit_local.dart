import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  static const String dataKey = 'local_data';
  static const String isUploadedKey = 'is_data_uploaded';

  // Store data locally with an upload flag
  static Future<void> storeDataLocally(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final dataToStore = {
      'data': data,
      'isUploaded': false, // Initialize as not uploaded
    };
    await prefs.setString(dataKey, json.encode(dataToStore));
  }

  // Get locally stored data
  static Future<Map<String, dynamic>?> getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDataString = prefs.getString(dataKey);
    if (storedDataString != null) {
      final storedData = json.decode(storedDataString);
      return storedData['data'];
    }
    return null;
  }

  // Mark data as uploaded
  static Future<void> markDataAsUploaded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isUploadedKey, true);
  }

  // Check if data is marked as uploaded
  static Future<bool> isDataUploaded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUploadedKey) ?? false;
  }

  // Delete locally stored data
  static Future<void> deleteLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(dataKey);
    await prefs.remove(isUploadedKey);
  }
}
