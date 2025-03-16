import 'package:etammn/common/blocs/timer/timer_bloc.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/verification/View/verification_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/utilities.dart';
import '../../../utilities/validations.dart';
import '../../verification/Bloc/verification_code_bloc.dart';
import '../model/forgot_password_request_model.dart';
import '../repo/forgot_password_repo.dart';

class ForgotPasswordBloc extends BlocBase
    with APIBlocMixin<SuccessModel, ErrorModel>, Validations {
  final ForgotPasswordRepo _forgotPasswordRepo = ForgotPasswordRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");

  forgotPassword() async {
    Utilities.showLoadingDialog();
    ForgotPasswordRequestModel requestModel =
        ForgotPasswordRequestModel(email: emailSubject.value);
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

    var model = await _forgotPasswordRepo.forgotPassword(requestModel.toJson());
    Utilities.hideLoadingDialog();
    if (model is SuccessModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      Utilities.navigateAndPop(BlocProvider<TimerBloc>(
        bloc: TimerBloc(),
        child: BlocProvider<VerificationCodeBloc>(
            bloc: VerificationCodeBloc(email: emailSubject.value),
            child: const VerificationCodeView()),
      ));
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.error, message: 'ERROR'));
      emailSubject.sink.addError(model.message ?? '');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
    emailSubject.close();
  }
}
