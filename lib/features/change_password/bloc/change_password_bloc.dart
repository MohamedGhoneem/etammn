import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/profile/repo/splash_repo.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/models/error_model.dart';
import '../../../../../common/request_state.dart';
import '../../../../../core/api_bloc_mixin.dart';
import '../../../../../utilities/validations.dart';
import '../../../common/models/user_model.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../utilities/utilities.dart';
import '../../profile/model/profile_response_model.dart';
import '../../user_management/create_user/model/create_user_response_model.dart';
import '../../users/model/users_response_model.dart';

class ChangePasswordBloc extends BlocBase
    with APIBlocMixin<CreateUserResponseModel, ErrorModel>, Validations {
  final UserModel? content;
final bool? isUpdateProfile;
  ChangePasswordBloc({required this.content, required this.isUpdateProfile});

  final UsersRepo _usersRepo = UsersRepo();
  final ProfileRepo _profileRepo = ProfileRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BehaviorSubject<String> currentPasswordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> passwordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> confirmPasswordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<bool> obscureTextSubject = BehaviorSubject.seeded(true);



  String? validateConfirmNewPassword(String value) {
    if (value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).confirmNewPassword} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    if (value != passwordSubject.value) {
      return AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).passwordMismatch;
    }
    return null;
  }

  changePassword() async {
   if(isUpdateProfile == true){
     _changeProfilePassword();
   }else{
     _changeUserPassword();
   }
  }
  _changeProfilePassword() async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    Utilities.showLoadingDialog();
    var model = await _profileRepo.updateProfile(
        {"current_password":currentPasswordSubject.valueOrNull,"password": passwordSubject.valueOrNull});
    Utilities.hideLoadingDialog();
    if (model is ProfileResponseModel) {
      // super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(description: model.message ?? '', okBtnTapped:()=> Utilities.popWidget(),);

      Utilities.showAppDialog(appDialog);

    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(description: model.message ?? '');
      Utilities.showAppDialog(appDialog);
    }
  }

  _changeUserPassword() async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    Utilities.showLoadingDialog();
    var model = await _usersRepo.editUser(
        {"password": passwordSubject.valueOrNull, "password_confirmation": confirmPasswordSubject.valueOrNull},
        content?.id);
    Utilities.hideLoadingDialog();
    if (model is CreateUserResponseModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(description: model.message ?? '', okBtnTapped:()=> Utilities.popWidget(),);

      Utilities.showAppDialog(appDialog);

    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(description: model.message ?? '');
      Utilities.showAppDialog(appDialog);
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
