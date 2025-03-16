import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/models/error_model.dart';
import '../../../../../common/request_state.dart';
import '../../../../../core/api_bloc_mixin.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/validations.dart';
import '../../../../common/blocs/pick_file/file_picker_bloc.dart';
import '../../../../common/blocs/upload_files/upload_bloc.dart';
import '../../../../common/models/country_model.dart';
import '../../../../common/models/user_model.dart';
import '../../../../common/widgets/app_dialog.dart';
import '../../../../common/widgets/app_dialog_content.dart';
import '../../../../common/widgets/phone_number_field/countries.dart';
import '../../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../../utilities/constants/constants.dart';
import '../../../../utilities/localization/localizations.dart';
import '../../../../utilities/utilities.dart';
import '../../../../common/models/system_item_model.dart';
import '../../../sign_in/model/sign_in_response_model.dart';
import '../../../users/bloc/users_bloc.dart';
import '../../create_user/model/create_user_request_model.dart';
import '../../create_user/model/create_user_response_model.dart';
import 'package:validators/validators.dart' as validator;

import '../../user_details/bloc/user_details_bloc.dart';

class EditUserBloc extends BlocBase
    with APIBlocMixin<CreateUserResponseModel, ErrorModel>, Validations {
  final UserModel? content;
  final UserDetailsBloc? userDetailsBloc;

  EditUserBloc({required this.content, required this.userDetailsBloc}) {
    debugPrint('${content?.toJson()}');
    fetchUserData();
  }

  late Uint8List bytes;

  final UsersRepo _usersRepo = UsersRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // BehaviorSubject<String?> phoneNumberSubject = BehaviorSubject();
  // TextEditingController phoneNumberTextEditingController =
  //     TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  // BehaviorSubject<Color> phoneNumberContainerBorderColorSubject =
  //     BehaviorSubject.seeded(AppColors.greyColor);
  // BehaviorSubject<String?> phoneNumberErrorSubject = BehaviorSubject();

  BehaviorSubject<String> passwordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> confirmPasswordSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> userNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");
  BehaviorSubject<File> avatarSubject = BehaviorSubject<File>();
  BehaviorSubject<CountryModel> selectedCountrySubject = BehaviorSubject();
  String? avatarUrl;
  BehaviorSubject<List<SystemItemModel>?> userSystemSubject =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CheckedSystemsModel>> allowedSystemIdsSubject =
      BehaviorSubject.seeded([]);

  BehaviorSubject<int> usersControlSubject = BehaviorSubject.seeded(0);

  updateAllowedSystemIds(int? id) {
    List<CheckedSystemsModel> allowedSystemIds = allowedSystemIdsSubject.value;
    if (allowedSystemIds
        .contains(CheckedSystemsModel(systemId: id, systemControl: 1))) {
      allowedSystemIds
          .remove(CheckedSystemsModel(systemId: id, systemControl: 1));
    } else {
      allowedSystemIds
          .add(CheckedSystemsModel(systemId: id!, systemControl: 1));
    }
    allowedSystemIdsSubject.sink.add(allowedSystemIds);
  }

  updateSystemControl(int? id, bool controlValue) {
    List<CheckedSystemsModel> allowedSystemIds = allowedSystemIdsSubject.value;

    if (allowedSystemIds.contains(CheckedSystemsModel(systemId: id))) {
      allowedSystemIds.remove(CheckedSystemsModel(systemId: id));
      allowedSystemIds.add(CheckedSystemsModel(
          systemId: id, systemControl: controlValue ? 1 : 0));
    }
    allowedSystemIdsSubject.sink.add(allowedSystemIds);
  }

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
    checkPhoneValidation(false);
  }

  clearSelectedPhoneNumber() {
    alternatePhoneNumberSubject.sink.add(null);
    alternatePhoneNumberTextEditingController.text = '';
  }

  checkPhoneValidation(bool isInitialEmpty) {
    final valid =
        validatePhoneNumber(alternatePhoneNumberSubject.valueOrNull) == null ||
            isInitialEmpty;
    isValidPhone.sink.add(valid);
  }

  ///====================================
  editUser() async {
    if (isValidPhone.value == true) {
      if (allowedSystemIdsSubject.value.isEmpty) {
        AppDialog appDialog = AppDialog();
        appDialog.child = AppDialogContent(
            description: AppLocalizations.of(
                    AppConstants.navigatorKey.currentState!.context)
                .addSystems);
        Utilities.showAppDialog(appDialog);
      } else {
        CreateUserRequestModel requestModel;
        requestModel = CreateUserRequestModel(
            username: userNameSubject.valueOrNull,
            avatar: avatarUrl,
            email: emailSubject.valueOrNull,
            mobile: alternatePhoneNumberSubject.value?.number,
            countryKey:alternatePhoneNumberSubject.value?.countryCode ,
            iso: selectedCountrySubject.value.iso,
            usersControl: usersControlSubject.valueOrNull,
            operationLevel: 1,
            checkedSystems: allowedSystemIdsSubject.value);
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.loading, message: 'LOADING'));
        Utilities.showLoadingDialog();
        var model =
            await _usersRepo.editUser(requestModel.toJson(), content?.id);
        Utilities.hideLoadingDialog();
        if (model is CreateUserResponseModel) {
          super.successSubject.sink.add(model);
          requestStateSubject.sink.add(
              RequestState(status: RequestStatus.success, message: 'SUCCESS'));
          userDetailsBloc?.userModelSubject.sink
              .add(UserModel.fromJson(model.data?.toJson() ?? {}));
          usersBloc.getUsers();
          Utilities.popWidget();
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
    }
  }

  UploadBloc uploadBloc = UploadBloc();
  FilePickerBloc filePickerBloc = FilePickerBloc();

  pickFile() {
    filePickerBloc.type = FilePickerType.gallery;
    filePickerBloc.pickFile().then((value) {
      if (value != null) {
        uploadBloc.setFile(value.path);
        uploadBloc.uploadSingleFile();
        uploadBloc.successSubject.stream.listen((event) {
          avatarUrl = event.data;
          uploadBloc.errorSubject.stream.listen((event) {
            AppDialog appDialog = AppDialog();
            appDialog.child = AppDialogContent(
                description: AppLocalizations.of(
                        AppConstants.navigatorKey.currentState!.context)
                    .errorWhileUploading);
            Utilities.showAppDialog(appDialog);
          });
        });
      }
    });
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
  setDefaultMobileField(BehaviorSubject<PhoneNumber?> subject) {
    subject.sink
        .add(PhoneNumber(countryCode: '974', number: '', countryISOCode: 'QA'));
  }
  fetchUserData() {
    userNameTextEditingController.text = content?.username ?? '';
    userNameSubject.sink.add(content?.username ?? '');
    emailTextEditingController.text = content?.email ?? '';
    emailSubject.sink.add(content?.email ?? '');
    alternatePhoneNumberTextEditingController.text = content?.mobile ?? '';
    usersControlSubject.sink.add(content?.usersControl ?? 0);
    userSystemSubject.sink.add(content?.systems ?? []);
    PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: content?.countryKey??'',
        countryCode: '',
        number: content?.mobile ?? '');
    alternatePhoneNumberSubject.sink.add(phoneNumber);
    setMobileFieldValue("${content?.countryKey.toString()}${content?.mobile}",
        alternatePhoneNumberSubject);
    checkPhoneValidation(
        alternatePhoneNumberSubject.valueOrNull?.number.isEmpty ?? true);

    List<CheckedSystemsModel> allowedSystemIds = [];

    content?.systems?.forEach((element) {
      allowedSystemIds
          .add(CheckedSystemsModel(systemId: element.id, systemControl: 1));
      print('content?.systems : ${element.toJson()}');
    });
    allowedSystemIdsSubject.sink.add(allowedSystemIds);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
