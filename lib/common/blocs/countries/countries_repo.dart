// import 'package:dio/dio.dart';
// import 'package:etammn/core/base_model.dart';
// import '../../../core/network/api_constants.dart';
// import '../../../core/network/network.dart';
// import '../../models/error_model.dart';
// import 'countries_response_model.dart';
//
// class CountriesRepo {
//   Future<BaseModel> getCountries() async {
//     try {
//       try {
//         var response = await Network().performRequest(
//             ApiConstants.countriesUrl, {}, ServerMethods.get);
//         return CountriesResponseModel.fromJson(response.data);
//       } catch (e) {
//         return ErrorModel.fromJson(e as dynamic);
//       }
//     } catch (error) {
//       ErrorModel errorModel = ErrorModel(status: 500, message: error.toString());
//       return errorModel;
//     }
//   }
//
// }
