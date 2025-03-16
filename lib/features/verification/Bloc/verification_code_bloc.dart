import 'dart:async';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/reset_password/bloc/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/utilities.dart';
import '../../reset_password/view/reset_password_view.dart';
import '../Repo/verification_code_repo.dart';
import '../check_code_response_model.dart';

class VerificationCodeBloc extends BlocBase
    with APIBlocMixin<CheckCodeResponseModel, ErrorModel> {
  BehaviorSubject<String> verificationCodeSubject = BehaviorSubject.seeded("");
  BehaviorSubject<bool> loadingStateSubject = BehaviorSubject.seeded(false);
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  BehaviorSubject<bool> pinCodeHasErrorSubject = BehaviorSubject.seeded(false);
  String? _email;
  TextEditingController? pinCodeController;

  VerificationCodeBloc({required String email}) {
    _email = email;
  }

  checkCode() async {
    Map<String, dynamic> params = {"code": verificationCodeSubject.value};
    var model = await VerificationCodeRepo().checkCode(params);
    if (model is CheckCodeResponseModel) {
      successSubject.sink.add(model);
      Utilities.navigateAndPop(BlocProvider<ResetPasswordBloc>(
          bloc: ResetPasswordBloc(code: verificationCodeSubject.value),
          child: const ResetPasswordView()));
    }
    if (model is ErrorModel) {
      errorSubject.sink.add(model);
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(
        title:
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .alert,
        description: model.message ?? '',
        okButtonTitle:
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .ok,
      );
      Utilities.showAppDialog(appDialog);
    }
  }

  @override
  void dispose() {
    verificationCodeSubject.close();
    loadingStateSubject.close();
    errorController.close();
    pinCodeHasErrorSubject.close();
    pinCodeController?.dispose();
  }
}
