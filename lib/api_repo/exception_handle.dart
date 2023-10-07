import 'package:dio/dio.dart';
// import 'package:exenergy/utils/customToast.dart';
// import 'package:exenergy/utils/loadingIndicator.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to Api server was Cancelled";
        // showeErrrorDialouge("");
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with api error";
        // print("diomessage");
        // print(message);
        break;
      case DioExceptionType.unknown:
        message = "Internet conection gone";
        // showeErrrorDialouge("Opps! No Internet");
        // print("diomessage");
        // print(message);
        break;
      case DioExceptionType.receiveTimeout:
        message = "recieved timeout with api error";
        // print("diomessage");
        // print(message);
        break;
      // case DioExceptionType.response:
      //   message = handleerror(
      //       dioError.response!.statusCode!, dioError.response!.data);
      //   customeToast(message!);
      //   print("diomessage");
      //   print(message);
      //   break;
      case DioExceptionType.sendTimeout:
        message = "send out time connection with api errror";
        // print("diomessage");
        // print(message);
        break;
      default:
        message = "Somthing went wrong";
        // print("diomessage");
        // print(message);
        break;
    }
  }
}

handleerror(int statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return "Unauthorized request";
    case 401:
      return "Unauthorized request";
    case 403:
      return "Unauthorized request";
    case 404:
      return "Not found";
    case 409:
      return "Error due to conflict";
    case 408:
      return "connect request timeout";
    case 500:
      return "Internal server error";
    case 503:
      return "Service Unavailable";
    default:
      return "Opps something went wrong";
  }
}

String? message;
