// import 'package:etammn/common/models/country_model.dart';
// import 'package:etammn/core/bloc_provider.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../core/api_bloc_mixin.dart';
// import '../../models/error_model.dart';
// import '../../request_state.dart';
// import 'countries_response_model.dart';
// import 'countries_repo.dart';
//
// class CountriesBloc extends BlocBase
//     with APIBlocMixin<CountriesResponseModel, ErrorModel> {
//   BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
//       RequestState(status: RequestStatus.loading, message: ''));
//   CountriesRepo _countriesRepo = CountriesRepo();
//   List<CountryModel> countriesList = [];
//
//   Future getCountries() async {
//     var model = await _countriesRepo.getCountries();
//     if (model is CountriesResponseModel) {
//       super.successSubject.sink.add(model);
//       countriesList = model.data ?? [];
//       requestStateSubject.sink
//           .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
//     }
//     if (model is ErrorModel) {
//       super.errorSubject.sink.add(model);
//       requestStateSubject.sink.add(RequestState(
//           status: RequestStatus.error, message: model.message ?? ''));
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//   }
// }
// late CountriesBloc countriesBloc;