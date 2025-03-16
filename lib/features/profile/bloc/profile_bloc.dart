import 'dart:convert';
import 'package:etammn/common/models/user_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/pick_file/file_picker_bloc.dart';
import '../../../common/blocs/upload_files/upload_bloc.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/success_model.dart';
import '../../../common/request_state.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../../utilities/utilities.dart';
import '../../sign_in/model/sign_in_response_model.dart';
import '../model/profile_response_model.dart';
import '../repo/splash_repo.dart';

enum UpdateProfileEnum { avatar, email }

class ProfileBloc extends BlocBase
    with APIBlocMixin<ProfileResponseModel, ErrorModel>, Validations {
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  GlobalKey<FormState> formKey = GlobalKey();
  BehaviorSubject<bool> isEditingEmailSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<String?> emailSubject = BehaviorSubject();
  TextEditingController emailTextEditingController = TextEditingController();
  final ProfileRepo _profileRepo = ProfileRepo();
  final FocusNode emailFocusNode = FocusNode();

  String? email;

  getProfile() async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

    var model = await _profileRepo.getProfile();
    if (model is ProfileResponseModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      email = model.data?.email ?? '';
      emailTextEditingController.text = model.data?.email ?? '';
      SignInResponseModel signInResponseModel = SignInResponseModel.fromJson(
          json.decode(
              SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));

      signInResponseModel.user = UserModel.fromJson(model.data?.toJson() ?? {});
      SharedPreferenceHelper.setValueForKey(
          SharedPrefsKeys.userKey, signInResponseModel.encodingToJson());
    }
    if (model is ErrorModel) {
      // ErrorModel errorModel = ErrorModel(status: 500, message: 'ERROR');
      if (model.status == 403) {
        SharedPreferenceHelper.setValueForKey(SharedPrefsKeys.tokenKey, null);

        ///=====================================================================
      }
      super.errorSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.error, message: 'ERROR'));
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(
        description: model.message ?? '',
      );
      Utilities.showAppDialog(appDialog);
    }
  }

  updateProfile(UpdateProfileEnum updateEnum) async {
    if (formKey.currentState!.validate() &&
        updateEnum == UpdateProfileEnum.email &&
        email != emailTextEditingController.text &&
        isEditingEmailSubject.valueOrNull == true) {
      _updateProfile(updateEnum, {"email": emailTextEditingController.text});
    } else if (formKey.currentState!.validate() &&
        updateEnum == UpdateProfileEnum.avatar) {
      _updateProfile(updateEnum, {"avatar": avatarUrl});
    } else {
      isEditingEmailSubject.sink.add(false);
      emailTextEditingController.text = email ?? '';
      emailSubject.sink.add(email);
      return;
    }
  }

  _updateProfile(
      UpdateProfileEnum updateEnum, Map<String, dynamic> params) async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    // Utilities.showLoadingDialog();
    var model = await _profileRepo.updateProfile(params);
    // Utilities.hideLoadingDialog();
    if (model is ProfileResponseModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      if (updateEnum == UpdateProfileEnum.email) {
        isEditingEmailSubject.sink.add(false);
      }
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(
        description: model.message ?? '',
        okBtnTapped: () => Utilities.popWidget(),
      );

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

  UploadBloc uploadBloc = UploadBloc();
  FilePickerBloc filePickerBloc = FilePickerBloc();
  String? avatarUrl;

  pickFile() {
    filePickerBloc.type = FilePickerType.gallery;
    filePickerBloc.pickFile().then((value) {
      if (value != null) {
        uploadBloc.setFile(value.path);
        uploadBloc.uploadSingleFile();
        uploadBloc.successSubject.stream.listen((event) {
          avatarUrl = event.data;
          updateProfile(UpdateProfileEnum.avatar);
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

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}

ProfileBloc profileBloc = ProfileBloc();
