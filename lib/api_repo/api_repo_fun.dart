import 'dart:io';
import 'package:dio/dio.dart';
import 'package:onye_aghana_nwanne_ya/api_repo/exception_handle.dart';
import 'package:onye_aghana_nwanne_ya/api_repo/server_request.dart';
import 'package:onye_aghana_nwanne_ya/api_repo/service_constant.dart';

class ApiRepo {
  final Api _api = Api();
  Response? response;
  Options options = Options(
      headers: {
        HttpHeaders.authorizationHeader: 'YOUR KEY HERE',
      },
      validateStatus: (_) => true,
      contentType: 'application/json',
      responseType: ResponseType.json);

  // Future getBanners() async {
  //   try {
  //     Response response =
  //         await _api.request.get(ServiceConstant.BANNER, options: options);

  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       // customeToast("Something went wrong");
  //     }
  //   } on DioException catch (e) {
  //     DioExceptions.fromDioError(e);
  //     // customSnakebar("Internal server error");
  //   }
  // }

// Check Validation
  Future checkValidation(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.validation, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // Login
  Future login(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.login, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // Registration
  Future registration(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.registration, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // otp resend
  Future resendOtp(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.resendOtp, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // user edit
  Future userEditApi(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.userEdit, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // User update
  Future userUpdateApi(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.userUpdate, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // user password change
  Future userPasswordChange(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request.post(
          ServiceConstant.userPasswordChange,
          options: options,
          data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // user password reset
  Future userResetPassword(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request.post(
          ServiceConstant.userResetPassword,
          options: options,
          data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // user password update
  Future userUpdatePassword(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request.post(
          ServiceConstant.userUpdatePassword,
          options: options,
          data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  // forms
  Future forms(Map<String, dynamic> data) async {
    try {
      Response response = await _api.request
          .post(ServiceConstant.forms, options: options, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // customeToast("Something went wrong");
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
    }
  }
}
