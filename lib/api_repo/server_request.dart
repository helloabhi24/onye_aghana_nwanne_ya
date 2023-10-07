import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = "https://misoftwaresolutions.com/csdvoters/api/";

    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      error: true,
      responseBody: true,
      compact: true,
    ));
  }

  Dio get request => _dio;

  Future checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return "Internet Connectivity";
    } else if (connectivityResult == ConnectivityResult.none) {
      return "no internet connect";
    }
    return connectivityResult;
  }
}
