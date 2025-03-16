import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/countries/countries_bloc.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/models/error_model.dart';
import '../../../common/request_state.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/utilities.dart';
import '../../../utilities/validations.dart';
import '../../change_language/bloc/change_language_bloc.dart';
import '../../sign_in/bloc/sign_in_bloc.dart';
import '../../sign_in/view/sign_in_view.dart';
import '../model/reset_password_request_model.dart';
import '../repo/reset_password_repo.dart';

class ResetPasswordBloc extends BlocBase
    with APIBlocMixin<SuccessModel, ErrorModel>, Validations {
  final ResetPasswordRepo _changePasswordRepo = ResetPasswordRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BehaviorSubject<bool> obscureTextSubject = BehaviorSubject.seeded(true);
  BehaviorSubject<String> newPasswordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> confirmNewPasswordSubject =
      BehaviorSubject.seeded("");
  String? _code;

  ResetPasswordBloc({required String code}) {
    _code = code;
  }

  String? validateConfirmNewPassword(String value) {
    if (value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).confirmPassword} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    if (value != newPasswordSubject.value) {
      return AppLocalizations.of(
              AppConstants.navigatorKey.currentState!.context)
          .passwordMismatch;
    }
    return null;
  }

  resetPassword() async {
    Utilities.showLoadingDialog();
    ChangePasswordRequestModel requestModel = ChangePasswordRequestModel(
        code: _code,
        password: newPasswordSubject.value,
        passwordConfirmation: confirmNewPasswordSubject.value);
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

    var model = await _changePasswordRepo.resetPassword(requestModel.toJson());
    Utilities.hideLoadingDialog();
    if (model is SuccessModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(
        title:
        AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
            .alert,
        description: model.message ?? '',
        okButtonTitle:
        AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
            .ok,
        okBtnTapped: (){
          Utilities.navigateAndPop(
            BlocProvider(
              bloc: ChangeLanguageBloc(),
              child: BlocProvider<FirebaseTokenBloc>(
                bloc: FirebaseTokenBloc(),
                child: BlocProvider(
                    bloc: SignInBloc(),
                    child: const SignInView(),

                ),
              ),
            ),
          );
        },
      );
      Utilities.showAppDialog(appDialog);
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.error, message: 'ERROR'));
      confirmNewPasswordSubject.sink.addError(model.message ?? '');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
    newPasswordSubject.close();
    confirmNewPasswordSubject.close();
  }
}
