import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../../common/models/error_model.dart';

import '../../utilities/constants/constants.dart';
import '../../utilities/localization/localizations.dart';
import '../../utilities/shared_preferences_helper.dart';
import '../../utilities/shared_preferences_keys.dart';
import '../../utilities/utilities.dart';
import 'api_constants.dart';

enum ServerMethods { get, post, update, delete, put, patch }

class Network {
  static final Network shared = Network._private();
  Dio client = Dio();
  String baseUrl = ApiConstants.baseUrl;

  factory Network() {
    return shared;
  }

  bool noNetworkDialogOpened = false;

  Network._private() {
    client.options.connectTimeout = const Duration(seconds: 12);
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (_client) {
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> _isWifiOrMobileDataEnabled() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Wi-Fi or mobile data is enabled
      return true;
    } else {
      // Neither Wi-Fi nor mobile data is enabled
      return false;
    }
  }

  Future sendQueryParams(
      String endpoint, Map<String, dynamic> parms, ServerMethods method,
      {Map<String, dynamic>? putOrDeleteParams}) async {
    Map<String, dynamic>? queryParams = {};
    if (method == ServerMethods.get) {
      queryParams = parms;
    } else if (method == ServerMethods.put || method == ServerMethods.delete) {
      queryParams = putOrDeleteParams;
    }
    return _performRequest(endpoint,
        queryParms: parms, method: method.toString().split(".").last);
  }

  Future performRequest(
      String endpoint, Map<String, dynamic> parms, ServerMethods method,
      {Map<String, dynamic>? putOrDeleteParams}) async {
    Map<String, dynamic>? queryParams = {};

    bool isOnline = await hasNetwork();
    if (isOnline) {
      if (method == ServerMethods.get) {
        queryParams = parms;
      } else if (method == ServerMethods.put ||
          method == ServerMethods.delete) {
        queryParams = putOrDeleteParams;
      }
      return _performRequest(endpoint,
          queryParms: queryParams!,
          bodyParms: parms,
          method: method.toString().split(".").last);
    } else {
      // if (!noNetworkDialogOpened) {
      //   noNetworkDialogOpened = true;
      //   AppDialog appDialog = AppDialog();
      //   appDialog.child = AppDialogContent(
      //       title: AppLocalizations.of(
      //               AppConstants.navigatorKey.currentState!.context)
      //           .title,
      //       description: AppLocalizations.of(
      //               AppConstants.navigatorKey.currentState!.context)
      //           .noInternetConnection,
      //       okButtonTitle: AppLocalizations.of(
      //               AppConstants.navigatorKey.currentState!.context)
      //           .ok,
      //       cancelButtonTitle: AppLocalizations.of(
      //               AppConstants.navigatorKey.currentState!.context)
      //           .cancel,
      //       okBtnTapped: () {
      //         noNetworkDialogOpened = false;
      //         Utilities.popWidget();
      //       });
      //   Utilities.showAppDialog(appDialog);
      // }
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
              AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    }
  }

  Future performDynamicRequest(
      String endpoint, dynamic parms, ServerMethods method,
      {dynamic putOrDeleteParams}) async {
    dynamic queryParams;
    if (method == ServerMethods.get) {
      queryParams = parms;
    } else if (method == ServerMethods.put || method == ServerMethods.delete) {
      queryParams = putOrDeleteParams;
    }
    return _performDynamicRequest(endpoint,
        //  queryParms: queryParams!,
        bodyParms: parms,
        method: method.toString().split(".").last);
  }

  Future performMultipartRequest(
      String endpoint, FormData params, ServerMethods? method,
      {Map<String, dynamic>? putOrDeleteParams}) async {
    log('${params.fields} ===== ${params.files.first.value.filename}');
    return _performRequest2(endpoint,
        body: params, method: method.toString().split(".").last);
  }

  Future _performRequest(String endpoint,
      {Map<String, dynamic>? bodyParms,
      Map<String, dynamic>? queryParms,
      String? method}) async {
    Map<String, dynamic>? headers = {};
    if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey) !=
        null) {
      headers["Authorization"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey);
      headers["lang"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.languageKey);
    }
    headers["Accept"] = "application/json";
    log('headers $headers');
    try {
      log('$bodyParms');
      log('$queryParms');
      if (endpoint.toLowerCase().contains("upload")) {
        baseUrl = "${ApiConstants.baseUrl}api/";
      } else {
        baseUrl = ApiConstants.baseUrl;
      }
      log('$method  =======>>    $baseUrl$endpoint');

      Response response = await client.request(baseUrl + endpoint,
          data: bodyParms,
          queryParameters: queryParms,
          options: Options(method: method, headers: headers));
      log("code : ${response.statusCode}");
      log("$endpoint: $response");
      return response;
    } on SocketException catch (e) {
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);

      throw errorModel.toJson();
    } on DioError catch (e) {
      log("$endpoint errorrrrrr=======>>  ${e.response!.data}");
      throw e.response!.data;
    } catch (error) {
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    }
  }

  Future _performDynamicRequest(String endpoint,
      {dynamic bodyParms, dynamic queryParms, String? method}) async {
    Map<String, dynamic>? headers = {};
    if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey) !=
        null) {
      headers["Authorization"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey);
      headers["lang"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.languageKey);
    }
    headers["Accept"] = "application/json";
    log('headers $headers');
    try {
      log('$bodyParms');
      log('$queryParms');
      if (endpoint.toLowerCase().contains("upload")) {
        baseUrl = "${ApiConstants.baseUrl}api/";
      } else {
        baseUrl = ApiConstants.baseUrl;
      }
      log('$method  =======>>    $baseUrl$endpoint');

      Response response = await client.request(baseUrl + endpoint,
          data: bodyParms, options: Options(method: method, headers: headers));
      log("$endpoint: $response");
      return response;
    } on SocketException catch (e) {
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    } on DioError catch (e) {
      log("$endpoint errorrrrrr=======>>  ${e.response!.data}");
      throw e.response!.data;
    } catch (error) {
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    }
  }

  Future _performRequest2(String endpoint, {body, String? method}) async {
    Map<String, dynamic>? headers = {};
    if (SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey) !=
        null) {
      headers["Authorization"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.tokenKey);
      headers["lang"] =
          SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.languageKey);
    }
    headers["Accept"] = "application/json";
    log('headers $headers');
    try {
      log('$method  =======>>    $baseUrl$endpoint');
      Response response = await client.request(baseUrl + endpoint,
          data: body, options: Options(method: method, headers: headers));
      log("$endpoint: $response");
      return response;
    } on SocketException catch (e) {
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    } on DioError catch (e) {
      log("$endpoint errorrrrrr=======>>  ${e.response!.data}");
      throw e.response!.data;
    } catch (error) {
      log("$endpoint errorrrrrr=======>>  ${error.toString()}");
      ErrorModel errorModel = ErrorModel(
          status: 500,
          message: AppLocalizations.of(
                  AppConstants.navigatorKey.currentState!.context)
              .noInternetConnection);
      throw errorModel.toJson();
    }
  }

  Future uploadFileRequest(
      String endpoint, FormData parms, ServerMethods method,
      {Map<String, dynamic>? putOrDeleteParams}) async {
    return _performRequest2(endpoint,
        body: parms, method: method.toString().split(".").last);
  }
}
