import 'dart:async';

import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/common/models/system_item_model.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/features/system_details/view/system_details_view.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../common/blocs/timer/timer_bloc.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../../sign_in/model/sign_in_response_model.dart';
import 'item_status_widget.dart';

class DashboardItemWidget extends StatefulWidget {
  final SystemItemModel? content;

  const DashboardItemWidget({Key? key, required this.content})
      : super(key: key);

  @override
  State<DashboardItemWidget> createState() => _DashboardItemWidgetState();
}

class _DashboardItemWidgetState extends State<DashboardItemWidget> {
  BehaviorSubject<bool> alarmSubject = BehaviorSubject.seeded(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.content?.isOnline == true && widget.content?.alarmCount != 0) {
      startAlarm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utilities.navigate(BlocProvider<TimerBloc>(
        bloc: TimerBloc(),
        child: BlocProvider(
          bloc: SystemDetailsBloc(systemId: widget.content?.id),
          child: const SystemDetailsView(),
        ),
      )),
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.padding),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
            color: AppColors.profileItemBGColor(),
            border: Border.all(
                color: AppColors.lightGreyColor.withOpacity(.4), width: 1),
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: AppText(
                  label: widget.content?.location?.buildingName ?? '',
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor()),
                )),
                AppText(
                  label: widget.content?.isOnline != null &&
                          widget.content?.isOnline != false
                      ? AppLocalizations.of(context).online
                      : AppLocalizations.of(context).offline,
                  style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.textFontSize,
                    fontColor: widget.content?.isOnline == true
                        ? AppColors.greenColor
                        : AppColors.redColor,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.padding / 2,
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: widget.content?.isOnline == true
                          ? AppColors.greenColor
                          : AppColors.redColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.btnRadius))),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.padding / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: AppColors.greyColor,
                  size: SizeConfig.smallIconSize,
                ),
                SizedBox(
                  width: SizeConfig.padding / 2,
                ),
                AppText(
                  label:
                      '${widget.content?.location?.country?.name} / ${widget.content?.location?.district?.name}' ??
                          '',
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.greyColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder<bool>(
                      stream: alarmSubject.stream,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ItemStatusWidget(
                                iconPath: AppAssets.fire,
                                title: '',
                                text: AppLocalizations.of(context).fire,
                                count: widget.content?.isOnline == true
                                    ? widget.content?.alarmCount.toString()
                                    : '0',
                                bgColor: snapshot.data == true
                                    ? AppColors.redColor
                                    : AppColors.primaryColor,
                                fontColor: snapshot.data == true
                                    ? AppColors.redColor
                                    : AppColors.primaryColor,
                              )
                            : const SizedBox();
                      }),
                ),
                SizedBox(
                  width: SizeConfig.padding / 2,
                ),
                Expanded(
                  child: ItemStatusWidget(
                    iconPath: AppAssets.faults,
                    title: '',
                    text: AppLocalizations.of(context).faults,
                    count: widget.content?.isOnline == true
                        ? widget.content?.faultCount.toString()
                        : '0',
                    bgColor: AppColors.faultsColor,
                    fontColor: AppColors.faultsColor,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.padding / 2,
                ),
                if (widget.content?.isOnline == true &&
                    widget.content?.currentMode != null)
                  Expanded(
                    child: ItemStatusWidget(
                      title: AppLocalizations.of(context).currentMode,
                      text: widget.content?.currentMode?.localizedName,
                      bgColor: AppColors.lightGreyColor,
                      fontColor: AppColors.blueColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
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
}
