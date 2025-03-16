import 'dart:convert';

import 'package:etammn/common/blocs/change_system_mode/repo/change_system_mode_repo.dart';
import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/network/network.dart';
import '../../../../utilities/constants/app_text_style.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/shared_preferences_helper.dart';
import '../../../../utilities/shared_preferences_keys.dart';
import '../../../../utilities/size_config.dart';
import '../../../models/error_model.dart';
import '../../../request_state.dart';
import '../../../widgets/app_bottom_sheet.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_dialog_content.dart';
import '../../../widgets/app_expanded_radio_button.dart';
import '../../../widgets/app_text.dart';
import '../../modes/model/modes_response_model.dart';

class ChangeSystemModeBloc {
  ChangeSystemModeBloc() {
    ModesResponseModel modesResponseModel = ModesResponseModel.fromJson(
        json.decode(
            SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.modesKey)));
    modesSubject.sink.add(modesResponseModel.data?.modes);
    timesSubject.sink.add(modesResponseModel.data?.times);

    modesSubject.value?.forEach((element) {
      if (element.name?.toLowerCase() == SystemModeEnum.incense.name) {
        bakhourMode = element;
      }
    });
  }

  bool inLiveMode = false;
  final ChangeSystemModeRepo _changeSystemModeRepo = ChangeSystemModeRepo();
  bool isFirstLoad = true;
  bool extended = false;
  BehaviorSubject<List<Modes>?> modesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<List<Times>?> timesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<Times?> selectedTimesSubject = BehaviorSubject();
  Modes? bakhourMode;
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));

  checkBokhorMode(Modes? selectedMode, int? systemId) {
    if (selectedMode?.withDuration == true) {
      openBottomSheet(selectedMode, systemId!);
    } else {
      changeSystemMode(selectedMode, systemId!);
    }
  }

  changeSystemMode(Modes? selectedMode, int systemId) async {
    bool isOnline = await Network().hasNetwork();
    if (isOnline) {
    debugPrint('selectedMode : ${selectedMode?.name}');
    String? currentMode =
        SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.selectedModeKey);
    debugPrint('currentMode : $currentMode');

    if (currentMode == SystemModeEnum.live.name &&
        selectedMode?.name?.toLowerCase() == SystemModeEnum.live.name) {
      inLiveMode = true;
    } else {
      inLiveMode = false;
    }
    if (selectedMode != null && !inLiveMode) {
      var params = {
        'currentMode': selectedMode.name,
        'extended': extended,
        if (selectedTimesSubject.hasValue == true)
          'time': selectedTimesSubject.valueOrNull?.time
      };
      Utilities.showLoadingDialog();

      var model =
          await _changeSystemModeRepo.changeSystemMode(systemId, params);
      Utilities.hideLoadingDialog();
      if (model is SuccessModel) {
        AppDialog appDialog = AppDialog();
        appDialog.child = AppDialogContent(description: model.message ?? '');
        Utilities.showAppDialog(appDialog);
        dashboardBloc.getDashboard();

        SharedPreferenceHelper.setValueForKey(
            SharedPrefsKeys.selectedModeKey, selectedMode.name?.toLowerCase());

        requestStateSubject.sink
            .add(RequestState(status: RequestStatus.success, message: ''));
      }
      if (model is ErrorModel) {
        AppDialog appDialog = AppDialog();
        appDialog.child = AppDialogContent(description: model.message ?? '');
        Utilities.showAppDialog(appDialog);
        requestStateSubject.sink
            .add(RequestState(status: RequestStatus.error, message: ''));
      }
    }
  } else {
  AppDialog appDialog = AppDialog();
  appDialog.child = AppDialogContent(
  description:
  AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
      .noInternetConnection,
  );
  Utilities.showAppDialog(appDialog);
  }
  }

  openBottomSheet(Modes? selectedMode, int systemId) {
    AppBottomSheet(
      context: AppConstants.navigatorKey.currentState!.context,
      bgColor: AppColors.whiteColor,
      bottomSheetTitle: AppText(
        label:
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .selectDuration,
        style: AppTextStyle.style(
            fontFamily: '',
            fontSize: SizeConfig.titleFontSize,
            fontColor: AppColors.primaryColor),
      ),
      bottomSheetContent: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.btnRadius),
                topRight: Radius.circular(SizeConfig.btnRadius))),
        child: StreamBuilder<List<Times>?>(
            stream: timesSubject.stream,
            builder: (context, snapshot) {
              return StreamBuilder<Times?>(
                  stream: selectedTimesSubject.stream,
                  builder: (context, selectedSnapshot) {
                    return Column(
                      children: List.generate(
                        snapshot.data?.length ?? 0,
                        (index) => AppExpandedRadioButton(
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.greyColor,
                          onTap: () {
                            selectedTimesSubject.sink
                                .add(snapshot.data?[index]);
                          },
                          labelFontColor: AppColors.fontColor(),
                          labelFontSize: SizeConfig.titleFontSize,
                          isSelected: selectedSnapshot.hasData &&
                                  selectedSnapshot.data?.time ==
                                      snapshot.data?[index].time
                              ? true
                              : false,
                          label: snapshot.data?[index].localizedName ?? '',
                        ),
                      ),
                    );
                  });
            }),
      ),
      bottomSheetButtons: StreamBuilder<Times?>(
          stream: selectedTimesSubject.stream,
          builder: (context, snapshot) {
            return AppButton(
                title: snapshot.hasData
                    ? AppLocalizations.of(
                            AppConstants.navigatorKey.currentState!.context)
                        .confirm.toUpperCase()
                    : AppLocalizations.of(
                            AppConstants.navigatorKey.currentState!.context)
                        .cancel.toUpperCase(),
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.whiteColor),
                borderColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor,
                width: SizeConfig.blockSizeHorizontal * 100,
                radius: SizeConfig.blockSizeHorizontal * 2,
                alignment: AppButtonAlign.center,
                margin: EdgeInsets.all(SizeConfig.padding),
                onTap: () {
                  Utilities.popWidget();
                  selectedTimesSubject.hasValue == true
                      ? changeSystemMode(selectedMode, systemId)
                      : null;
                });
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
