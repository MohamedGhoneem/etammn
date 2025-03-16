import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/localization/localizations.dart';
import '../model/users_response_model.dart';

class UsersBloc extends BlocBase
    with APIBlocMixin<UsersResponseModel, ErrorModel> {
  final UsersRepo _usersRepo = UsersRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));

  getUsers() async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

    var model = await _usersRepo.getUsers();
    if (model is UsersResponseModel) {
      super.successSubject.sink.add(model);
      if (model.data!=null && model.data!.isEmpty) {
        requestStateSubject.sink.add(RequestState(
            status: RequestStatus.noData,
            message: AppLocalizations.of(
                AppConstants.navigatorKey.currentState!.context)
                .noDataFound));
      } else {
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      }
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}

UsersBloc usersBloc = UsersBloc();
