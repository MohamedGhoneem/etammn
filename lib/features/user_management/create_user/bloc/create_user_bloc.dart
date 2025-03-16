import 'dart:io';
import 'package:etammn/common/widgets/app_dialog_content.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/users/bloc/users_bloc.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/blocs/pick_file/file_picker_bloc.dart';
import '../../../../../common/blocs/upload_files/upload_bloc.dart';
import '../../../../../common/models/error_model.dart';
import '../../../../../common/request_state.dart';
import '../../../../../common/widgets/app_dialog.dart';
import '../../../../../core/api_bloc_mixin.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../utilities/validations.dart';
import '../../../../common/models/country_model.dart';
import '../../../../common/widgets/phone_number_field/phone_number.dart';
import '../model/create_user_request_model.dart';
import '../model/create_user_response_model.dart';
import 'package:validators/validators.dart' as validator;

class CreateUserBloc extends BlocBase
    with APIBlocMixin<CreateUserResponseModel, ErrorModel>, Validations {
  final UsersRepo _usersRepo = UsersRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // BehaviorSubject<String?> phoneNumberSubject = BehaviorSubject();
  // TextEditingController phoneNumberTextEditingController =
  //     TextEditingController();
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
      allowedSystemIds.add(CheckedSystemsModel(systemId: id, systemControl: 1));
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

  createUser() async {
    checkPhoneValidation();

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
        if (avatarUrl != null && avatarUrl != '') {
          requestModel = CreateUserRequestModel(
              username: userNameSubject.valueOrNull,
              avatar: avatarUrl,
              email: emailSubject.valueOrNull,
              mobile: alternatePhoneNumberSubject.value?.number,
              countryKey:
                  alternatePhoneNumberSubject.value?.countryCode.toString(),
              iso: selectedCountrySubject.value.iso,
              password: passwordSubject.valueOrNull,
              passwordConfirmation: confirmPasswordSubject.valueOrNull,
              usersControl: usersControlSubject.valueOrNull,
              operationLevel: 1,
              checkedSystems: allowedSystemIdsSubject.value);
        } else {
          requestModel = CreateUserRequestModel(
              username: userNameSubject.valueOrNull,
              email: emailSubject.valueOrNull,
              mobile: alternatePhoneNumberSubject.valueOrNull?.number,
              countryKey: alternatePhoneNumberSubject.valueOrNull?.countryCode
                  .toString(),
              iso: selectedCountrySubject.valueOrNull?.iso,
              password: passwordSubject.valueOrNull,
              passwordConfirmation: confirmPasswordSubject.valueOrNull,
              usersControl: usersControlSubject.valueOrNull,
              operationLevel: 1,
              checkedSystems: allowedSystemIdsSubject.value);
        }
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.loading, message: 'LOADING'));
        Utilities.showLoadingDialog();
        var model = await _usersRepo.createUser(requestModel.toJson());
        Utilities.hideLoadingDialog();
        if (model is CreateUserResponseModel) {
          super.successSubject.sink.add(model);
          requestStateSubject.sink.add(
              RequestState(status: RequestStatus.success, message: 'SUCCESS'));
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
      uploadBloc.setFile(value!.path);
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
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
