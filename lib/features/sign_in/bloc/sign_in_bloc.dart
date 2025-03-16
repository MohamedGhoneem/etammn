import 'package:dio/dio.dart';
import 'package:etammn/common/blocs/firebase_token/firebase_token_bloc.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:etammn/features/menu/bloc/menu_bloc.dart';
import 'package:etammn/features/notifications/bloc/notifications_bloc.dart';
import 'package:etammn/features/users/bloc/users_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/modes/bloc/modes_bloc.dart';
import '../../../common/models/country_model.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../common/request_state.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../../utilities/utilities.dart';
import '../../../utilities/validations.dart';
import '../../main_view.dart';
import '../model/sign_in_request_model.dart';
import '../model/sign_in_response_model.dart';
import '../repo/sign_in_repo.dart';
import 'package:validators/validators.dart' as validator;

class SignInBloc extends BlocBase
    with APIBlocMixin<SignInResponseModel, ErrorModel>, Validations {
  final SignInRepo _signInRepo = SignInRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BehaviorSubject<bool> obscureTextSubject = BehaviorSubject.seeded(true);

  BehaviorSubject<Color> phoneNumberContainerBorderColorSubject =
      BehaviorSubject.seeded(AppColors.greyColor);
  BehaviorSubject<String?> phoneNumberErrorSubject = BehaviorSubject();
  BehaviorSubject<String> passwordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<bool> rememberMeSubject = BehaviorSubject.seeded(true);
  BehaviorSubject<CountryModel> selectedCountrySubject = BehaviorSubject();

  /// Phone field ========================
  final BehaviorSubject<bool> isValidPhone = BehaviorSubject.seeded(true);
  BehaviorSubject<String> _phoneNumberSubject = BehaviorSubject();

  Stream<String> get phoneNumberStream => _phoneNumberSubject.stream;

  TextEditingController alternatePhoneNumberTextEditingController =
      TextEditingController();
  BehaviorSubject<PhoneNumber?> alternatePhoneNumberSubject =
      BehaviorSubject.seeded(
          PhoneNumber(countryCode: '', number: '', countryISOCode: 'QA'));

  Function(String) get onChangedPhoneNumberField {
    return _phoneNumberSubject.sink.add;
  }

  updateSelectedAlternatePhoneNumber(PhoneNumber number) {
    alternatePhoneNumberSubject.sink.add(number);
    checkPhoneValidation();
  }

  clearSelectedPhoneNumber() {
    alternatePhoneNumberSubject.sink.add(null);
    alternatePhoneNumberTextEditingController.text = '';
  }

  checkPhoneValidation() {
    final valid =
        validatePhoneNumber(alternatePhoneNumberSubject.value) == null;
    debugPrint('valid : $valid');

    isValidPhone.sink.add(valid);
  }

  ///====================================
  login(FirebaseTokenBloc firebaseTokenBloc) async {
    checkPhoneValidation();
    if (isValidPhone.value == true) {
      Utilities.showLoadingDialog();
      debugPrint(
          'selectedCountrySubject.value.phoneCode.toString() : ${alternatePhoneNumberSubject.value.toString()}');
      SignInRequestModel requestModel = SignInRequestModel(
          countryKey: alternatePhoneNumberSubject.value?.countryCode,
          mobile: alternatePhoneNumberSubject.value?.number,
          password: passwordSubject.value);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

      var model = await _signInRepo.login(requestModel.toJson());
      Utilities.hideLoadingDialog();
      if (model is SignInResponseModel) {
        super.successSubject.sink.add(model);
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.success, message: 'SUCCESS'));
        SharedPreferenceHelper.setValueForKey(
            SharedPrefsKeys.tokenKey, 'Bearer ${model.token}');
        SharedPreferenceHelper.setValueForKey(
            SharedPrefsKeys.userKey, model.encodingToJson());
        firebaseTokenBloc.getDeviceToken();
        modesBloc.getModes();
        Utilities.navigateAndPop(
          BlocProvider(
            bloc: UsersBloc(),
            child: BlocProvider(
              bloc: NotificationsBloc(),
              child: BlocProvider(bloc: MenuBloc(), child: const MainView()),
            ),
          ),
        );
      }
      if (model is ErrorModel) {
        super.errorSubject.sink.add(model);
        requestStateSubject.sink
            .add(RequestState(status: RequestStatus.error, message: 'ERROR'));
        // passwordSubject.sink.addError(model.message ?? '');
        AppDialog appDialog = AppDialog();
        appDialog.child = AppDialogContent(
          description: model.message ?? '',
        );
        Utilities.showAppDialog(appDialog);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
    obscureTextSubject.close();
    // phoneNumberSubject.close();
    passwordSubject.close();
    rememberMeSubject.close();
    alternatePhoneNumberSubject.close();
    isValidPhone.close();
  }
}
