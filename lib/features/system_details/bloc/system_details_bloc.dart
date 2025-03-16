import 'dart:async';
import 'dart:convert';

import 'package:etammn/common/blocs/timer/timer_bloc.dart';
import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/core/network/network.dart';
import 'package:etammn/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:etammn/features/system_details/model/system_events_response_model.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/blocs/modes/model/modes_response_model.dart';
import '../../../common/models/error_model.dart';
import '../../../common/request_state.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../model/system_details_response_model.dart';
import '../repo/system_details_repo.dart';

int? selectedSystemId;

enum SystemModeEnum { live, incense, firedrill, evacuation }

enum SystemCommandEnum { mute, silence, reset, firedrill, evacuation }

enum SystemCurrentStatusEnum { fire, faulty }

class SystemDetailsBloc extends BlocBase
    with APIBlocMixin<SystemDetailsResponseModel, ErrorModel> {
  SystemDetailsRepo _systemDetailsRepo = SystemDetailsRepo();
  int? systemId;
  bool isFirstLoad = true;
  BehaviorSubject<List<Modes>?> modesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<List<Times>?> timesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<Times?> selectedTimesSubject = BehaviorSubject();
  BehaviorSubject<Modes?> selectedModeSubject = BehaviorSubject();

  SystemDetailsBloc({required this.systemId}) {
    selectedSystemId = systemId;
    getSystemDetails();
    getSystemEvents('ActiveFaults');
    ModesResponseModel modesResponseModel = ModesResponseModel.fromJson(
        json.decode(
            SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.modesKey)));

    modesSubject.sink.add(modesResponseModel.data?.modes);
    timesSubject.sink.add(modesResponseModel.data?.times);
  }

  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<RequestState> dropDownStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.success, message: ''));
  BehaviorSubject<SystemEventsResponseModel> systemEventsSubject =
      BehaviorSubject();
  BehaviorSubject<RequestState> systemEventsRequestStateSubject =
      BehaviorSubject.seeded(
          RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<bool> alarmSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> timerIsRunningSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> resetButtonTappedSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> muteButtonTappedSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> silentButtonTappedSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> evacuateButtonTappedSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> fireDrillButtonTappedSubject =
      BehaviorSubject.seeded(false);
  BehaviorSubject<Color> modeContainerBorderColorSubject =
      BehaviorSubject.seeded(AppColors.greyColor);

  int activeEvents = 0;
  int eventsLogs = 1;
  BehaviorSubject<int> selectedEventsSubject = BehaviorSubject.seeded(0);
  ScrollController controller = ScrollController();

  changeSelectedTab(int tabIndex) {
    selectedEventsSubject.sink.add(tabIndex);
    getSystemEvents(tabIndex == 0 ? 'ActiveFaults' : 'All');
  }

  startAlarm() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick.isOdd) {
        alarmSubject.sink.add(true);
      } else {
        alarmSubject.sink.add(false);
      }
      if (timer.tick == 20) {
        timer.cancel();
      }
    });
  }

  getSystemDetails() async {
    bool isOnline = await Network().hasNetwork();
    if (isOnline) {
    if (isFirstLoad) {
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    }
    var model = await _systemDetailsRepo.getSystemDetails(selectedSystemId);
    if (model is SystemDetailsResponseModel) {
      if (model.data?.currentMode?.name?.toLowerCase() ==
          SystemModeEnum.live.name) {
        modesSubject.value?.forEach((element) {
          if (element.name?.toLowerCase() == SystemModeEnum.live.name) {
            selectedModeSubject.sink.add(element);
          }
        });
        SharedPreferenceHelper.setValueForKey(SharedPrefsKeys.selectedModeKey,
            model.data?.currentMode?.name?.toLowerCase());
      } else if (model.data?.currentMode?.name?.toLowerCase() ==
          SystemModeEnum.incense.name) {
        modesSubject.value?.forEach((element) {
          if (element.name?.toLowerCase() == SystemModeEnum.incense.name) {
            selectedModeSubject.sink.add(element);
          }
        });
      } else if (model.data?.currentMode?.name?.toLowerCase() ==
          SystemModeEnum.firedrill.name) {
        modesSubject.value?.forEach((element) {
          if (element.name?.toLowerCase() == SystemModeEnum.firedrill.name) {
            selectedModeSubject.sink.add(element);
          }
        });
      } else if (model.data?.currentMode?.name?.toLowerCase() ==
          SystemModeEnum.evacuation.name) {
        modesSubject.value?.forEach((element) {
          if (element.name?.toLowerCase() == SystemModeEnum.evacuation.name) {
            selectedModeSubject.sink.add(element);
          }
        });
      }
      if (model.data?.isOnline == true && model.data?.alarmCount != 0) {
        startAlarm();
      }
      if (model.data?.isOnline == true &&
          model.data?.alarmCount == 0 &&
          model.data?.faultCount != 0) {
        startAlarm();
      }

      // if (model.data?.isOnline == true &&
      //     model.data?.alarmCount == 0 &&
      //     model.data?.faultCount == 0) {
      // }
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      isFirstLoad = false;
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
    }
    getSystemEvents('ActiveFaults');
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

  getSystemEvents(String eventType) async {
    var params = {'page': 1, 'pageSize': 50, 'eventType': eventType};
    if (isFirstLoad) {
      systemEventsRequestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    }
    var model =
        await _systemDetailsRepo.getSystemEvents(selectedSystemId, params);
    if (model is SystemEventsResponseModel) {
      systemEventsSubject.sink.add(model);
      systemEventsRequestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      if (model.data?.data?.isEmpty == true) {
        systemEventsRequestStateSubject.sink.add(RequestState(
            status: RequestStatus.noData,
            message: AppLocalizations.of(
                    AppConstants.navigatorKey.currentState!.context)
                .noNewEvents));
      }
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      systemEventsRequestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
    }
  }

  // checkBokhorMode() {
  //   if (selectedModeSubject.value?.withDuration == true) {
  //     openBottomSheet();
  //   } else {
  //     changeSystemMode();
  //   }
  // }
  //
  // changeSystemMode() async {
  //   if (selectedModeSubject.valueOrNull != null) {
  //     var params = {
  //       'currentMode': selectedModeSubject.value?.name,
  //       if (selectedTimesSubject.hasValue == true)
  //         'time': selectedTimesSubject.valueOrNull?.time
  //     };
  //     Utilities.showLoadingDialog();
  //
  //     var model = await _systemDetailsRepo.changeSystemMode(systemId, params);
  //     Utilities.hideLoadingDialog();
  //     if (model is SuccessModel) {
  //       AppDialog appDialog = AppDialog();
  //       appDialog.child = AppDialogContent(description: model.message ?? '');
  //       Utilities.showAppDialog(appDialog);
  //       dashboardBloc.getDashboard();
  //       getSystemDetails();
  //       getSystemEvents('ActiveFaults');
  //     }
  //     if (model is ErrorModel) {
  //       AppDialog appDialog = AppDialog();
  //       appDialog.child = AppDialogContent(description: model.message ?? '');
  //       Utilities.showAppDialog(appDialog);
  //     }
  //   }
  // }

  changeSystemCommand(
      {required String command, required TimerBloc timerBloc}) async {
    var params = {'type': command};
    //Utilities.showLoadingDialog();
    bool isOnline = await Network().hasNetwork();
    if (isOnline) {
      timerBloc.incrementTimer(20);
      timerIsRunningSubject.sink.add(true);
      if (command == SystemCommandEnum.mute.name) {
        muteButtonTappedSubject.sink.add(true);
        silentButtonTappedSubject.sink.add(false);
        resetButtonTappedSubject.sink.add(false);
        evacuateButtonTappedSubject.sink.add(false);
        fireDrillButtonTappedSubject.sink.add(false);
      } else if (command == SystemCommandEnum.silence.name) {
        muteButtonTappedSubject.sink.add(false);
        silentButtonTappedSubject.sink.add(true);
        resetButtonTappedSubject.sink.add(false);
        evacuateButtonTappedSubject.sink.add(false);
        fireDrillButtonTappedSubject.sink.add(false);
      } else if (command == SystemCommandEnum.reset.name) {
        muteButtonTappedSubject.sink.add(false);
        resetButtonTappedSubject.sink.add(true);
        silentButtonTappedSubject.sink.add(false);
        evacuateButtonTappedSubject.sink.add(false);
        fireDrillButtonTappedSubject.sink.add(false);
      } else if (command == SystemCommandEnum.evacuation.name) {
        muteButtonTappedSubject.sink.add(false);
        resetButtonTappedSubject.sink.add(false);
        silentButtonTappedSubject.sink.add(false);
        evacuateButtonTappedSubject.sink.add(true);
        fireDrillButtonTappedSubject.sink.add(false);
      } else if (command == SystemCommandEnum.firedrill.name) {
        muteButtonTappedSubject.sink.add(false);
        resetButtonTappedSubject.sink.add(false);
        silentButtonTappedSubject.sink.add(false);
        evacuateButtonTappedSubject.sink.add(false);
        fireDrillButtonTappedSubject.sink.add(true);
      }
      var model = await _systemDetailsRepo.changeSystemCommand(
          selectedSystemId, params);
      AppDialog appDialog = AppDialog();
      String? message;
      if (model is SuccessModel) {
        message = model.message ?? '';

        await dashboardBloc.getDashboard();
        await getSystemDetails();
        await getSystemEvents('ActiveFaults');
      }
      if (model is ErrorModel) {
        message = model.message ?? '';
      }
      StreamSubscription<bool>? _timerStoppedSubscription;
      _timerStoppedSubscription ??=
          timerBloc.timerStoppedSubject.listen((event) async {
        if (event == true) {
          appDialog.child = AppDialogContent(description: message ?? '');
          Utilities.showAppDialog(appDialog);
          _timerStoppedSubscription?.cancel();
          timerIsRunningSubject.sink.add(false);
          muteButtonTappedSubject.sink.add(false);
          silentButtonTappedSubject.sink.add(false);
          resetButtonTappedSubject.sink.add(false);
          evacuateButtonTappedSubject.sink.add(false);
          fireDrillButtonTappedSubject.sink.add(false);
          timerBloc.resetTimer();
        }
      });
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

  // openBottomSheet() {
  //   AppBottomSheet(
  //     context: AppConstants.navigatorKey.currentState!.context,
  //     bgColor: AppColors.whiteColor,
  //     bottomSheetTitle: AppText(
  //       label:
  //           AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
  //               .selectDuration,
  //       style: AppTextStyle.style(
  //           fontFamily: '',
  //           fontSize: SizeConfig.titleFontSize,
  //           fontColor: AppColors.primaryColor),
  //     ),
  //     bottomSheetContent: Container(
  //       margin: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
  //       padding: EdgeInsets.all(SizeConfig.padding),
  //       decoration: BoxDecoration(
  //           color: AppColors.whiteColor,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(SizeConfig.btnRadius),
  //               topRight: Radius.circular(SizeConfig.btnRadius))),
  //       child: StreamBuilder<List<Times>?>(
  //           stream: timesSubject.stream,
  //           builder: (context, snapshot) {
  //             return StreamBuilder<Times?>(
  //                 stream: selectedTimesSubject.stream,
  //                 builder: (context, selectedSnapshot) {
  //                   return Column(
  //                     children: List.generate(
  //                       snapshot.data?.length ?? 0,
  //                       (index) => AppExpandedRadioButton(
  //                         activeColor: AppColors.primaryColor,
  //                         inactiveColor: AppColors.greyColor,
  //                         onTap: () {
  //                           selectedTimesSubject.sink
  //                               .add(snapshot.data?[index]);
  //                         },
  //                         labelFontColor: AppColors.fontColor(),
  //                         labelFontSize: SizeConfig.titleFontSize,
  //                         isSelected: selectedSnapshot.hasData &&
  //                                 selectedSnapshot.data?.time ==
  //                                     snapshot.data?[index].time
  //                             ? true
  //                             : false,
  //                         label: snapshot.data?[index].localizedName ?? '',
  //                       ),
  //                     ),
  //                   );
  //                 });
  //           }),
  //     ),
  //     bottomSheetButtons: AppButton(
  //         title: AppLocalizations.of(
  //                 AppConstants.navigatorKey.currentState!.context)
  //             .confirm,
  //         style: AppTextStyle.style(
  //             fontFamily: Fonts.regular.name,
  //             fontSize: SizeConfig.textFontSize,
  //             fontColor: AppColors.whiteColor),
  //         borderColor: AppColors.primaryColor,
  //         backgroundColor: AppColors.primaryColor,
  //         width: SizeConfig.blockSizeHorizontal * 100,
  //         radius: SizeConfig.blockSizeHorizontal * 2,
  //         alignment: AppButtonAlign.center,
  //         margin: EdgeInsets.all(SizeConfig.padding),
  //         onTap: () {
  //           Utilities.popWidget();
  //           selectedTimesSubject.hasValue == true ? changeSystemMode() : null;
  //         }),
  //   );
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}

final SystemDetailsBloc systemDetailsBloc =
    SystemDetailsBloc(systemId: selectedSystemId);
