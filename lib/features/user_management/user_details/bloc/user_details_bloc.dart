import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/users/bloc/users_bloc.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/models/error_model.dart';
import '../../../../../common/request_state.dart';
import '../../../../../common/widgets/app_dialog.dart';
import '../../../../../common/widgets/app_dialog_content.dart';
import '../../../../../core/api_bloc_mixin.dart';
import '../../../../../utilities/constants/constants.dart';
import '../../../../../utilities/localization/localizations.dart';
import '../../../../../utilities/validations.dart';
import '../../../../common/models/user_model.dart';
import '../../../../common/models/system_item_model.dart';
import '../../../sign_in/model/sign_in_response_model.dart';
import '../../../users/model/users_response_model.dart';
import '../../create_user/model/create_user_request_model.dart';

class UserDetailsBloc extends BlocBase
    with APIBlocMixin<SuccessModel, ErrorModel>, Validations {
  UserModel? userModel;

  UserDetailsBloc({required this.userModel}) {
    fetchUserData();
  }

  BehaviorSubject<UserModel?> userModelSubject = BehaviorSubject();

  final UsersRepo _usersRepo = UsersRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<List<SystemItemModel>?> userSystemSubject =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CheckedSystemsModel>> allowedSystemIdsSubject =
      BehaviorSubject.seeded([]);
  BehaviorSubject<int> usersControlSubject = BehaviorSubject.seeded(0);

  // updateAllowedSystemIds(int? id) {
  //   List<int> allowedSystemIds = allowedSystemIdsSubject.value;
  //   if (allowedSystemIds.contains(id)) {
  //     allowedSystemIds.remove(id);
  //   } else {
  //     allowedSystemIds.add(id!);
  //   }
  //   allowedSystemIdsSubject.sink.add(allowedSystemIds);
  // }
  fetchUserData() {
    // List<CheckedSystemsModel> allowedSystemIds = [];
    // userSystemSubject.sink.add(userModel?.systems ?? []);
    // userModel?.systems?.forEach((element) {
    //   allowedSystemIds
    //       .add(CheckedSystemsModel(systemId: element.id, systemControl: 1));
    // });
    // allowedSystemIdsSubject.sink.add(allowedSystemIds);
    // userModelSubject.sink.add(userModel);
    // userModelSubject.stream.listen((event) {
    //   usersControlSubject.sink
    //       .add(int.parse(event?.usersControl.toString() ?? '0'));
    // });

    List<CheckedSystemsModel> allowedSystemIds = [];

    userModelSubject.sink.add(userModel);
    userModelSubject.stream.listen((event) {
      usersControlSubject.sink
          .add(int.parse(event?.usersControl.toString() ?? '0'));
      userSystemSubject.sink.add(event?.systems ?? []);
      event?.systems?.forEach((element) {
        allowedSystemIds
            .add(CheckedSystemsModel(systemId: element.id, systemControl: 1));
      });
      allowedSystemIdsSubject.sink.add(allowedSystemIds);
      userModel = event;
     // userModelSubject.sink.add(userModel);

    });
  }

  deleteUser() async {
    AppDialog appDialog = AppDialog();
    appDialog.child = AppDialogContent(
      title:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .alert,
      description:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .continueDeleting,
      okButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .ok,
      cancelButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .cancel,
      cancelBtnTapped: () {
        Utilities.popWidget();
      },
      okBtnTapped: () async {
        Utilities.popWidget();

        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.loading, message: 'LOADING'));
        Utilities.showLoadingDialog();
        var model = await _usersRepo.deleteUser(userModel?.id);
        Utilities.hideLoadingDialog();
        if (model is SuccessModel) {
          super.successSubject.sink.add(model);
          requestStateSubject.sink.add(
              RequestState(status: RequestStatus.success, message: 'SUCCESS'));
          AppDialog appDialog = AppDialog();
          appDialog.child = AppDialogContent(
            title: AppLocalizations.of(
                    AppConstants.navigatorKey.currentState!.context)
                .alert,
            description: model.message ?? '',
            okButtonTitle: AppLocalizations.of(
                    AppConstants.navigatorKey.currentState!.context)
                .ok,
            okBtnTapped: () {
              Utilities.popWidget();
              Utilities.popWidget();
              usersBloc.getUsers();
            },
          );
          Utilities.showAppDialog(appDialog);
        }
        if (model is ErrorModel) {
          super.errorSubject.sink.add(model);
          requestStateSubject.sink.add(RequestState(
              status: RequestStatus.error, message: model.message ?? ''));
          AppDialog appDialog = AppDialog();
          appDialog.child = AppDialogContent(
              title: AppLocalizations.of(
                      AppConstants.navigatorKey.currentState!.context)
                  .alert,
              description: model.message ?? '',
              okButtonTitle: AppLocalizations.of(
                      AppConstants.navigatorKey.currentState!.context)
                  .ok);
          Utilities.showAppDialog(appDialog);
        }
      },
    );
    Utilities.showAppDialog(appDialog);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
