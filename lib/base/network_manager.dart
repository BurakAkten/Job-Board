import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:job_board/utils/extensions/string_extension.dart';
import '../../translations/locale_keys.g.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager.internal();

  NetworkManager.internal();

  factory NetworkManager() => _instance;

  final JsonDecoder _decoder = const JsonDecoder();

  Future<NetworkResponse> makeRequest(String url, {body, int timeOutInSec = 15, RequestType type = RequestType.get}) async {
    if ((await Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return NetworkResponse(errorMessage: LocaleKeys.controlInternetConnectionAndTryAgain.locale, isConnectionProblem: true);
    }

    var httpHeader = {"accept": "application/json", "Content-Type": "application/json"};

    try {
      switch (type) {
        case RequestType.get:
          return http
              .get(Uri.parse(url), headers: httpHeader)
              .timeout(Duration(seconds: timeOutInSec))
              .catchError((_) => http.Response('{"Status": "UnKnown"}', 500))
              .then((response) => parseResponse(response, url, body, type));
      }
    } catch (e) {
      return NetworkResponse(isConnectionProblem: true, errorMessage: LocaleKeys.sthWentWrong.locale);
    }
  }

  FutureOr<NetworkResponse> parseResponse(http.Response response, String url, body, requestType) async {
    try {
      String apiResponse = response.body;
      int statusCode = response.statusCode;
      var result = _decoder.convert(apiResponse);
      if (statusCode == 200) {
        return NetworkResponse(isSuccess: true, data: result);
      } else {
        return NetworkResponse(isSuccess: false, errorMessage: LocaleKeys.sthWentWrong.locale);
      }
    } catch (e) {
      return NetworkResponse(isConnectionProblem: true, errorMessage: LocaleKeys.sthWentWrong.locale);
    }
  }
}

enum RequestType { get }

class NetworkResponse {
  final bool isSuccess;
  final String? errorMessage;
  final bool isConnectionProblem;
  final List<dynamic>? data;

  NetworkResponse({
    this.isSuccess = false,
    this.errorMessage,
    this.isConnectionProblem = false,
    this.data,
  });
}
