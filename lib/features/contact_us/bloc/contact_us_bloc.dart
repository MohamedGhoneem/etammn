import 'dart:convert';

import 'package:etammn/core/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/models/country_model.dart';
import '../../../../common/models/error_model.dart';
import '../../../../common/models/success_model.dart';
import '../../../../common/models/user_model.dart';
import '../../../../common/request_state.dart';
import '../../../../core/api_bloc_mixin.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/shared_preferences_helper.dart';
import '../../../../utilities/shared_preferences_keys.dart';
import '../../../../utilities/utilities.dart';
import '../../../../utilities/validations.dart';
import 'package:validators/validators.dart' as validator;

import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../common/widgets/phone_number_field/countries.dart';
import '../../../common/widgets/phone_number_field/phone_number.dart';
import '../../sign_in/model/sign_in_response_model.dart';
import '../model/contact_us_request_model.dart';
import '../repo/contact_us_repo.dart';

class ContactUsBloc extends BlocBase
    with APIBlocMixin<SuccessModel, ErrorModel>, Validations {
  final ContactUsRepo _contactUsRepo = ContactUsRepo();

  ContactUsBloc() {
    init();
  }

  UserModel? userModel;

  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
    RequestState(status: RequestStatus.loading, message: ''),
  );

  final ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final BehaviorSubject<String> emailSubject = BehaviorSubject();

  final BehaviorSubject<String> fullNameSubject = BehaviorSubject();

  final BehaviorSubject<String> phoneSubject = BehaviorSubject();

  final BehaviorSubject<String> subjectSubject = BehaviorSubject();

  Stream<String> get subjectStream => subjectSubject.stream;

  final BehaviorSubject<String> bodySubject = BehaviorSubject();

  final BehaviorSubject<bool> _isValidateFormSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isValidateFormStream => _isValidateFormSubject.stream;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
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
  setDefaultMobileField(BehaviorSubject<PhoneNumber?> subject) {
    subject.sink
        .add(PhoneNumber(countryCode: '974', number: '', countryISOCode: 'QA'));
  }
  setMobileFieldValue(String number, BehaviorSubject<PhoneNumber?> subject) {
    if (number != null && number.length > 8) {
      String dailCode1 = '${number[0]}${number[1]}${number[2]}${number[3]}';
      String dailCode2 = '${number[0]}${number[1]}${number[2]}';
      String dailCode3 = '${number[0]}${number[1]}';
      String dailCode4 = number[0];

      Country country = countries.firstWhere(
              (element) => (element.code == dailCode1 ||
              element.code == dailCode2 ||
              element.code == dailCode3 ||
              element.code == dailCode4),
          orElse: () => const Country(
              name: '',
              flag: '',
              code: '',
              dialCode: '',
              minLength: 0,
              maxLength: 0,
              nameTranslations: {}));
      if (country.name != '' && country.dialCode != '' && country.code != '') {
        alternatePhoneNumberSubject.sink.add(PhoneNumber(
            countryCode: country.dialCode,
            number: number.replaceFirst(country.code, ''),
            countryISOCode: country.code));
        alternatePhoneNumberTextEditingController.text =
            number.replaceFirst(country.code, '');
      } else {
        setDefaultMobileField(subject);
      }
    } else {
      setDefaultMobileField(subject);
    }
  }

  ///====================================
  void init() {
    var data = SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey);
    if (data != null) {
      SignInResponseModel model =
          SignInResponseModel.fromJson(json.decode(data));
      userModel = model.user;
      nameTextController.text = userModel?.username ?? '';
      fullNameSubject.sink.add(userModel?.username ?? '');
      emailTextController.text = userModel?.email ?? '';
      emailSubject.sink.add(userModel?.email ?? '');
      alternatePhoneNumberTextEditingController.text = userModel?.mobile ?? '';
      setMobileFieldValue("${userModel?.countryKey}${userModel?.mobile}",
          alternatePhoneNumberSubject);
      _phoneNumberSubject.sink.add(userModel?.mobile ?? '');
    }
  }

  contactUs() async {
    checkPhoneValidation();
    if (isValidPhone.value == true) {
      Utilities.showLoadingDialog();
      ContactUsRequestModel requestModel = ContactUsRequestModel(
          userId: userModel?.id,
          name: fullNameSubject.valueOrNull,
          email: emailSubject.valueOrNull,
          countryKey: alternatePhoneNumberSubject.value?.countryCode,
          phone: alternatePhoneNumberSubject.value?.number,
          subject: subjectSubject.valueOrNull,
          body: bodySubject.valueOrNull,
          countryId: selectedCountrySubject.valueOrNull?.id);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

      var model = await _contactUsRepo.contactUs(requestModel.toJson());
      Utilities.hideLoadingDialog();
      if (model is SuccessModel) {
        super.successSubject.sink.add(model);
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      }
      if (model is ErrorModel) {
        super.errorSubject.sink.add(model);
        requestStateSubject.sink
            .add(RequestState(status: RequestStatus.error, message: 'ERROR'));
        // passwordSubject.sink.addError(model.message ?? '');
        AppDialog appDialog = AppDialog();
        appDialog.child = AppDialogContent(
          description: model.message ?? '',
          okBtnTapped: () => Utilities.popWidget(),
        );
        Utilities.showAppDialog(appDialog);

      }
    }
  }

  @override
  void dispose() {
    fullNameSubject.close();
    emailSubject.close();
    phoneSubject.close();
    subjectSubject.close();
    bodySubject.close();
    _isValidateFormSubject.close();
    requestStateSubject.close();
    isValidPhone.close();
  }
}
