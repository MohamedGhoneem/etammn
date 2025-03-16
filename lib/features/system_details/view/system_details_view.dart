import 'dart:convert';
import 'package:etammn/common/models/drop_down_model.dart';
import 'package:etammn/common/widgets/app_back_icon.dart';
import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_divider.dart';
import 'package:etammn/common/widgets/app_streaming_result.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/features/system_details/view/widget/system_details_header_widget.dart';
import 'package:etammn/features/system_details/view/widget/system_events_widget.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../common/blocs/change_system_mode/bloc/change_system_mode_bloc.dart';
import '../../../common/blocs/modes/model/modes_response_model.dart';
import '../../../common/blocs/timer/timer_bloc.dart';
import '../../../common/models/user_model.dart';
import '../../../common/widgets/app_dialog.dart';
import '../../../common/widgets/app_dialog_content.dart';
import '../../../common/widgets/app_dropdown.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../sign_in/model/sign_in_response_model.dart';
import '../model/system_details_response_model.dart';
import 'widget/events_tabs_widget.dart';

class SystemDetailsView extends BaseStatefulWidget {
  const SystemDetailsView({Key? key}) : super(key: key);

  @override
  _SystemDetailsViewState createState() => _SystemDetailsViewState();
}

class _SystemDetailsViewState extends BaseState<SystemDetailsView> {
  // late SystemDetailsBloc systemDetailsBloc;
  late UserModel _userModel;
  late SignInResponseModel model;
  late TimerBloc timerBloc;
  ChangeSystemModeBloc changeSystemModeBloc = ChangeSystemModeBloc();

  @override
  void initState() {
    super.initState();
    // systemDetailsBloc = BlocProvider.of<SystemDetailsBloc>(context);
    systemDetailsBloc.isFirstLoad = true;
    systemDetailsBloc.getSystemDetails();
    timerBloc = BlocProvider.of<TimerBloc>(context);
    model = SignInResponseModel.fromJson(json.decode(
        SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));
    _userModel = model.user ?? UserModel();
    changeSystemModeBloc.requestStateSubject.listen((value) {
      systemDetailsBloc.getSystemDetails();
    });
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return Padding(
      padding: EdgeInsets.all(SizeConfig.padding),
      child: StreamBuilder<SystemDetailsResponseModel>(
          stream: systemDetailsBloc.successStream,
          builder: (context, systemDetailsSnapshot) {
            return AppStreamingResult(
              subject: systemDetailsBloc.requestStateSubject,
              successWidget: StreamBuilder<bool>(
                  stream: systemDetailsBloc.timerIsRunningSubject.stream,
                  builder: (context, silentOrResetSnapshot) {
                    return RefreshIndicator(
                      onRefresh: () => systemDetailsBloc.getSystemDetails(),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SystemDetailsHeaderWidget(
                            content: systemDetailsSnapshot.data,
                            bloc: systemDetailsBloc,
                          ),
                          AppDivider(
                            dividerHeight: SizeConfig.padding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: StreamBuilder<bool>(
                                    stream: systemDetailsBloc
                                        .muteButtonTappedSubject.stream,
                                    builder: (context, muteSnapshot) {
                                      return AppButton(
                                          title: muteSnapshot.hasData &&
                                                  muteSnapshot.data == true
                                              ? ''
                                              : AppLocalizations.of(context)
                                                  .mute,
                                          borderColor: AppColors.greyColor,
                                          backgroundColor: AppColors.greyColor,
                                          icon: muteSnapshot.hasData &&
                                                  muteSnapshot.data == true
                                              ? StreamBuilder<int>(
                                                  stream: timerBloc.timerStream,
                                                  builder: (context,
                                                      AsyncSnapshot<int>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      return AppText(
                                                        label: Utilities
                                                            .formattedTime(
                                                                snapshot.data ??
                                                                    120),
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    } else {
                                                      return AppText(
                                                        label: '00:20',
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    }
                                                  })
                                              : SvgPicture.asset(
                                                  AppAssets.mute,
                                                  width:
                                                      SizeConfig.iconSize * 2,
                                                  height:
                                                      SizeConfig.iconSize * 2,
                                                  color: AppColors.whiteColor,
                                                ),
                                          style: AppTextStyle.style(
                                              fontFamily: '',
                                              fontSize: SizeConfig.textFontSize,
                                              fontColor: AppColors.whiteColor),
                                          alignment:
                                              AppButtonAlign.centerStartIcon,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                          onTap: () {
                                            if (systemDetailsSnapshot.data?.data
                                                    ?.systemControl ==
                                                1) {
                                              if (silentOrResetSnapshot
                                                      .hasData &&
                                                  silentOrResetSnapshot.data ==
                                                      false &&
                                                  systemDetailsSnapshot.data
                                                          ?.data?.isOnline ==
                                                      true) {
                                                systemDetailsBloc
                                                    .changeSystemCommand(
                                                        command:
                                                            SystemCommandEnum
                                                                .mute.name,
                                                        timerBloc: timerBloc);
                                              }
                                            } else {
                                              AppDialog appDialog = AppDialog();
                                              appDialog.child = AppDialogContent(
                                                  description: AppLocalizations
                                                          .of(context)
                                                      .youHaveNoAccessForRemoteControl);
                                              Utilities.showAppDialog(
                                                  appDialog);
                                            }
                                          });
                                    }),
                              ),
                              SizedBox(
                                width: SizeConfig.padding / 2,
                              ),
                              Expanded(
                                child: StreamBuilder<bool>(
                                    stream: systemDetailsBloc
                                        .silentButtonTappedSubject.stream,
                                    builder: (context, silentSnapshot) {
                                      return AppButton(
                                          title: silentSnapshot.hasData &&
                                                  silentSnapshot.data == true
                                              ? ''
                                              : AppLocalizations.of(context)
                                                  .silent,
                                          borderColor: AppColors.primaryColor,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          icon: silentSnapshot.hasData &&
                                                  silentSnapshot.data == true
                                              ? StreamBuilder<int>(
                                                  stream: timerBloc.timerStream,
                                                  builder: (context,
                                                      AsyncSnapshot<int>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      return AppText(
                                                        label: Utilities
                                                            .formattedTime(
                                                                snapshot.data ??
                                                                    120),
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    } else {
                                                      return AppText(
                                                        label: '00:20',
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    }
                                                  })
                                              : SvgPicture.asset(
                                                  AppAssets.silent,
                                                  width: SizeConfig.iconSize,
                                                  height: SizeConfig.iconSize,
                                                  color: AppColors.whiteColor,
                                                ),
                                          style: AppTextStyle.style(
                                              fontFamily: '',
                                              fontSize: SizeConfig.textFontSize,
                                              fontColor: AppColors.whiteColor),
                                          alignment:
                                              AppButtonAlign.centerStartIcon,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                          onTap: () {
                                            if (systemDetailsSnapshot.data?.data
                                                    ?.systemControl ==
                                                1) {
                                              if (silentOrResetSnapshot
                                                      .hasData &&
                                                  silentOrResetSnapshot.data ==
                                                      false &&
                                                  systemDetailsSnapshot.data
                                                          ?.data?.isOnline ==
                                                      true) {
                                                systemDetailsBloc
                                                    .changeSystemCommand(
                                                        command:
                                                            SystemCommandEnum
                                                                .silence.name,
                                                        timerBloc: timerBloc);
                                              }
                                            } else {
                                              AppDialog appDialog = AppDialog();
                                              appDialog.child = AppDialogContent(
                                                  description: AppLocalizations
                                                          .of(context)
                                                      .youHaveNoAccessForRemoteControl);
                                              Utilities.showAppDialog(
                                                  appDialog);
                                            }
                                          });
                                    }),
                              ),
                              SizedBox(
                                width: SizeConfig.padding / 2,
                              ),
                              Expanded(
                                child: StreamBuilder<bool>(
                                    stream: systemDetailsBloc
                                        .resetButtonTappedSubject.stream,
                                    builder: (context, resetSnapshot) {
                                      return AppButton(
                                          title: resetSnapshot.hasData &&
                                                  resetSnapshot.data == true
                                              ? ''
                                              : AppLocalizations.of(context)
                                                  .reset,
                                          borderColor: AppColors.resetBtnColor,
                                          backgroundColor:
                                              AppColors.resetBtnColor,
                                          icon: resetSnapshot.hasData &&
                                                  resetSnapshot.data == true
                                              ? StreamBuilder<int>(
                                                  stream: timerBloc.timerStream,
                                                  builder: (context,
                                                      AsyncSnapshot<int>
                                                          snapshot) {
                                                    if (snapshot.hasData) {
                                                      return AppText(
                                                        label: Utilities
                                                            .formattedTime(
                                                                snapshot.data ??
                                                                    120),
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    } else {
                                                      return AppText(
                                                        label: '00:20',
                                                        style: AppTextStyle.style(
                                                            fontFamily:
                                                                Fonts.bold.name,
                                                            fontSize: SizeConfig
                                                                .textFontSize,
                                                            fontColor: AppColors
                                                                .whiteColor),
                                                      );
                                                    }
                                                  })
                                              : SvgPicture.asset(
                                                  AppAssets.reset,
                                                  width: SizeConfig.iconSize,
                                                  height: SizeConfig.iconSize,
                                                  color: AppColors.whiteColor,
                                                ),
                                          style: AppTextStyle.style(
                                              fontFamily: '',
                                              fontSize: SizeConfig.textFontSize,
                                              fontColor: AppColors.whiteColor),
                                          alignment:
                                              AppButtonAlign.centerStartIcon,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                          onTap: () {
                                            if (systemDetailsSnapshot.data?.data
                                                    ?.systemControl ==
                                                1) {
                                              if (silentOrResetSnapshot
                                                      .hasData &&
                                                  silentOrResetSnapshot.data ==
                                                      false &&
                                                  systemDetailsSnapshot.data
                                                          ?.data?.isOnline ==
                                                      true) {
                                                systemDetailsBloc
                                                    .changeSystemCommand(
                                                        command:
                                                            SystemCommandEnum
                                                                .reset.name,
                                                        timerBloc: timerBloc);
                                              }
                                            } else {
                                              AppDialog appDialog = AppDialog();
                                              appDialog.child = AppDialogContent(
                                                  description: AppLocalizations
                                                          .of(context)
                                                      .youHaveNoAccessForRemoteControl);
                                              Utilities.showAppDialog(
                                                  appDialog);
                                            }
                                          });
                                    }),
                              ),
                              SizedBox(
                                width: SizeConfig.padding / 2,
                              ),
                              systemDetailsSnapshot.hasData &&
                                      systemDetailsSnapshot
                                              .data?.data?.currentMode?.name
                                              ?.toLowerCase() ==
                                          SystemModeEnum.firedrill.name
                                  ? Expanded(
                                      child: StreamBuilder<bool>(
                                          stream: systemDetailsBloc
                                              .fireDrillButtonTappedSubject
                                              .stream,
                                          builder: (context, snapshot) {
                                            return AppButton(
                                                title: snapshot.hasData &&
                                                        snapshot.data == true
                                                    ? ''
                                                    : AppLocalizations.of(context)
                                                        .fireDrill,
                                                borderColor:
                                                    AppColors.orangeColor,
                                                backgroundColor:
                                                    AppColors.orangeColor,
                                                icon: snapshot.hasData &&
                                                        snapshot.data == true
                                                    ? StreamBuilder<int>(
                                                        stream: timerBloc
                                                            .timerStream,
                                                        builder: (context,
                                                            AsyncSnapshot<int>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return AppText(
                                                              label: Utilities
                                                                  .formattedTime(
                                                                      snapshot.data ??
                                                                          120),
                                                              style: AppTextStyle.style(
                                                                  fontFamily:
                                                                      Fonts.bold
                                                                          .name,
                                                                  fontSize:
                                                                      SizeConfig
                                                                          .textFontSize,
                                                                  fontColor:
                                                                      AppColors
                                                                          .whiteColor),
                                                            );
                                                          } else {
                                                            return AppText(
                                                              label: '00:20',
                                                              style: AppTextStyle.style(
                                                                  fontFamily:
                                                                      Fonts.bold
                                                                          .name,
                                                                  fontSize:
                                                                      SizeConfig
                                                                          .textFontSize,
                                                                  fontColor:
                                                                      AppColors
                                                                          .whiteColor),
                                                            );
                                                          }
                                                        })
                                                    : SvgPicture.asset(
                                                        AppAssets.speaker,
                                                        width:
                                                            SizeConfig.iconSize,
                                                        height:
                                                            SizeConfig.iconSize,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                style: AppTextStyle.style(
                                                    fontFamily: '',
                                                    fontSize:
                                                        SizeConfig.textFontSize,
                                                    fontColor:
                                                        AppColors.whiteColor),
                                                alignment: AppButtonAlign
                                                    .centerStartIcon,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    25,
                                                radius: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                onTap: () {
                                                  if (systemDetailsSnapshot
                                                          .data
                                                          ?.data
                                                          ?.systemControl ==
                                                      1) {
                                                    if (silentOrResetSnapshot
                                                            .hasData &&
                                                        silentOrResetSnapshot
                                                                .data ==
                                                            false &&
                                                        systemDetailsSnapshot
                                                                .data
                                                                ?.data
                                                                ?.isOnline ==
                                                            true) {
                                                      AppDialog appDialog =
                                                          AppDialog();
                                                      appDialog.child =
                                                          AppDialogContent(
                                                        description:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .fireDrillConfirmationMessage,
                                                        okButtonTitle:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .yes,
                                                        cancelButtonTitle:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .no,
                                                        okBtnTapped: () {
                                                          Utilities.popWidget();
                                                          systemDetailsBloc
                                                              .changeSystemCommand(
                                                                  command:
                                                                      SystemCommandEnum
                                                                          .firedrill
                                                                          .name,
                                                                  timerBloc:
                                                                      timerBloc);
                                                        },
                                                        cancelBtnTapped: () {
                                                          Utilities.popWidget();
                                                        },
                                                      );
                                                      Utilities.showAppDialog(
                                                          appDialog);
                                                    }
                                                  } else {
                                                    AppDialog appDialog =
                                                        AppDialog();
                                                    appDialog.child = AppDialogContent(
                                                        description:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .youHaveNoAccessForRemoteControl);
                                                    Utilities.showAppDialog(
                                                        appDialog);
                                                  }
                                                });
                                          }),
                                    )
                                  : Expanded(
                                      child: StreamBuilder<bool>(
                                          stream: systemDetailsBloc
                                              .evacuateButtonTappedSubject
                                              .stream,
                                          builder: (context, snapshot) {
                                            return AppButton(
                                                title: snapshot.hasData &&
                                                        snapshot.data == true
                                                    ? ''
                                                    : AppLocalizations.of(context)
                                                        .evacuation,
                                                borderColor: AppColors.redColor,
                                                backgroundColor:
                                                    AppColors.redColor,
                                                icon: snapshot.hasData &&
                                                        snapshot.data == true
                                                    ? StreamBuilder<int>(
                                                        stream: timerBloc
                                                            .timerStream,
                                                        builder: (context,
                                                            AsyncSnapshot<int>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return AppText(
                                                              label: Utilities
                                                                  .formattedTime(
                                                                      snapshot.data ??
                                                                          120),
                                                              style: AppTextStyle.style(
                                                                  fontFamily:
                                                                      Fonts.bold
                                                                          .name,
                                                                  fontSize:
                                                                      SizeConfig
                                                                          .textFontSize,
                                                                  fontColor:
                                                                      AppColors
                                                                          .whiteColor),
                                                            );
                                                          } else {
                                                            return AppText(
                                                              label: '00:20',
                                                              style: AppTextStyle.style(
                                                                  fontFamily:
                                                                      Fonts.bold
                                                                          .name,
                                                                  fontSize:
                                                                      SizeConfig
                                                                          .textFontSize,
                                                                  fontColor:
                                                                      AppColors
                                                                          .whiteColor),
                                                            );
                                                          }
                                                        })
                                                    : SvgPicture.asset(
                                                        AppAssets.speaker,
                                                        width:
                                                            SizeConfig.iconSize,
                                                        height:
                                                            SizeConfig.iconSize,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                style: AppTextStyle.style(
                                                    fontFamily: '',
                                                    fontSize:
                                                        SizeConfig.textFontSize,
                                                    fontColor:
                                                        AppColors.whiteColor),
                                                alignment: AppButtonAlign
                                                    .centerStartIcon,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    25,
                                                radius: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                onTap: () {
                                                  if (systemDetailsSnapshot
                                                          .data
                                                          ?.data
                                                          ?.systemControl ==
                                                      1) {
                                                    if (silentOrResetSnapshot
                                                            .hasData &&
                                                        silentOrResetSnapshot
                                                                .data ==
                                                            false &&
                                                        systemDetailsSnapshot
                                                                .data
                                                                ?.data
                                                                ?.isOnline ==
                                                            true) {
                                                      AppDialog appDialog =
                                                          AppDialog();
                                                      appDialog.child =
                                                          AppDialogContent(
                                                        description:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .evacuateConfirmationMessage,
                                                        okButtonTitle:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .yes,
                                                        cancelButtonTitle:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .no,
                                                        okBtnTapped: () {
                                                          Utilities.popWidget();
                                                          systemDetailsBloc
                                                              .changeSystemCommand(
                                                                  command:
                                                                      SystemCommandEnum
                                                                          .evacuation
                                                                          .name,
                                                                  timerBloc:
                                                                      timerBloc);
                                                        },
                                                        cancelBtnTapped: () {
                                                          Utilities.popWidget();
                                                        },
                                                      );
                                                      Utilities.showAppDialog(
                                                          appDialog);
                                                    }
                                                  } else {
                                                    AppDialog appDialog =
                                                        AppDialog();
                                                    appDialog.child = AppDialogContent(
                                                        description:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .youHaveNoAccessForRemoteControl);
                                                    Utilities.showAppDialog(
                                                        appDialog);
                                                  }
                                                });
                                          }),
                                    ),
                            ],
                          ),
                          AppDivider(
                            dividerHeight: SizeConfig.padding,
                          ),
                          AppText(
                            label:
                                '${AppLocalizations.of(context).changeMode}:',
                            style: AppTextStyle.style(
                                fontFamily: '',
                                fontSize: SizeConfig.textFontSize,
                                fontColor: AppColors.fontColor()),
                          ),
                          SizedBox(
                            height: SizeConfig.padding,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.padding),
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      border: Border.all(
                                          color: AppColors.lightGreyColor
                                              .withOpacity(.4),
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.btnRadius * 2))),
                                  child: StreamBuilder<List<Modes>?>(
                                      stream:
                                          systemDetailsBloc.modesSubject.stream,
                                      builder: (context, snapshot) {
                                        return StreamBuilder<Modes?>(
                                            stream: systemDetailsBloc
                                                .selectedModeSubject.stream,
                                            builder: (context,
                                                selectedModeSnapshot) {
                                              return AppDropdown<Modes?>(
                                                  hint: AppLocalizations.of(
                                                          context)
                                                      .selectMode,
                                                  titleKey: 'localized_name',
                                                  selectedItem:
                                                      selectedModeSnapshot
                                                              .hasData
                                                          ? selectedModeSnapshot
                                                              .data
                                                          : null,
                                                  icon: SvgPicture.asset(
                                                    AppAssets.dropdown,
                                                    width:
                                                        SizeConfig.iconSize / 2,
                                                  ),
                                                  items: snapshot.hasData
                                                      ? snapshot.data!
                                                      : [],
                                                  // readOnly: systemDetailsSnapshot
                                                  //                 .data
                                                  //                 ?.data
                                                  //                 ?.systemControl ==
                                                  //             1 &&
                                                  //         silentOrResetSnapshot
                                                  //             .hasData &&
                                                  //         silentOrResetSnapshot.data ==
                                                  //             false &&
                                                  //         systemDetailsSnapshot
                                                  //                 .data
                                                  //                 ?.data
                                                  //                 ?.isOnline ==
                                                  //             true
                                                  //     ? false
                                                  //     : true,
                                                  onChange: (value) {
                                                    systemDetailsBloc
                                                        .selectedModeSubject
                                                        .sink
                                                        .add(value);
                                                  },
                                                  onTap: null,
                                                  validator: (value) => value ==
                                                          null
                                                      ? AppLocalizations.of(
                                                              context)
                                                          .selectMode
                                                      : null,
                                                  style: AppTextStyle.style(
                                                    fontFamily:
                                                        Fonts.regular.name,
                                                    fontSize:
                                                        SizeConfig.textFontSize,
                                                    fontColor:
                                                        AppColors.fontColor(),
                                                  ));
                                            });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.padding,
                              ),
                              StreamBuilder<bool>(
                                  stream: systemDetailsBloc
                                      .timerIsRunningSubject.stream,
                                  builder: (context, silentOrResetSnapshot) {
                                    return AppButton(
                                        title: '',
                                        borderColor: AppColors.primaryColor,
                                        backgroundColor: AppColors.primaryColor,
                                        icon: const Icon(
                                          Icons.check_sharp,
                                          size: 30,
                                          color: AppColors.whiteColor,
                                        ),
                                        style: AppTextStyle.style(
                                            fontFamily: '',
                                            fontSize: SizeConfig.textFontSize,
                                            fontColor: AppColors.whiteColor),
                                        alignment:
                                            AppButtonAlign.centerStartIcon,
                                        width: SizeConfig.btnHeight,
                                        height: SizeConfig.btnHeight,
                                        radius: SizeConfig.btnHeight,
                                        onTap: systemDetailsSnapshot.data?.data
                                                        ?.systemControl ==
                                                    1 &&
                                                silentOrResetSnapshot.hasData &&
                                                silentOrResetSnapshot.data ==
                                                    false &&
                                                systemDetailsSnapshot
                                                        .data?.data?.isOnline ==
                                                    true
                                            ? () => changeSystemModeBloc
                                                .checkBokhorMode(
                                                    systemDetailsBloc
                                                        .selectedModeSubject
                                                        .valueOrNull,
                                            selectedSystemId)
                                            : null);
                                  }),
                            ],
                          ),
                          AppDivider(
                            dividerHeight: SizeConfig.padding,
                          ),
                          EventsTabsWidget(
                            bloc: systemDetailsBloc,
                          ),
                          SystemEventsWidget(bloc: systemDetailsBloc),
                        ],
                      ),
                    );
                  }),
              retry: () => systemDetailsBloc.getSystemDetails(),
            );
          }),
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    // TODO: implement setAppbar
    return PreferredSize(
      preferredSize:
          Size(SizeConfig.blockSizeHorizontal * 100, SizeConfig.appBarHeight),
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.only(
              left: SizeConfig.padding,
              top: MediaQuery.of(context).viewPadding.top,
              right: SizeConfig.padding,
              bottom: SizeConfig.padding),
          decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border.fromBorderSide(BorderSide(
                color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
          ),
          child: Row(
            children: [
              AppBackIcon(
                onTap: setOnWillPop,
              ),
              Expanded(
                  child: AppText(
                label: AppLocalizations.of(context).systemDetails,
                style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.fontColor()),
                textAlign: TextAlign.center,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                child: SizedBox(
                  width: SizeConfig.iconSize,
                ),
              )
            ],
          )),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement setScaffoldBackgroundColor
    return AppColors.backGroundColor();
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }

  @override
  Future<bool> setOnWillPop() {
    // TODO: implement setOnWillPop
    if (systemDetailsBloc.timerIsRunningSubject.value == true) {
      return Future.value(false);
    } else {
      return super.setOnWillPop();
    }
  }
}
