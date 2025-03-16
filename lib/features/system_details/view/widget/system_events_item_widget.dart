import 'dart:convert';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../model/system_events_response_model.dart';

class SystemEventsItemWidget extends StatelessWidget {
  final EventModel? content;

  const SystemEventsItemWidget({Key? key, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.padding),
      padding: EdgeInsets.all(SizeConfig.padding),
      decoration: BoxDecoration(
          color: AppColors.profileItemBGColor(),
          border: Border.all(
              color: AppColors.lightGreyColor.withOpacity(.4), width: 1),
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage(
            path: content?.sound?.toLowerCase() == 'fire'
                ? AppAssets.fire
                : AppAssets.faults,
            width: SizeConfig.iconSize,
            height: SizeConfig.iconSize,
            boxFit: BoxFit.fill,
            isCircular: true,
          ),
          SizedBox(width: SizeConfig.padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label: content?.eventType ?? '',
                  style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.fontColor(),
                  ),
                ),
                if (content?.textLocation != null &&
                    content?.textLocation != '')
                  SizedBox(height: SizeConfig.blockSizeVertical / 2),
                if (content?.textLocation != null &&
                    content?.textLocation != '')
                  AppText(
                    label: content?.textLocation ?? '',
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.lightFontColor(),
                    ),
                  ),
              //  if (content?.deviceType != null && content?.deviceType != '')
                  SizedBox(height: SizeConfig.blockSizeVertical / 2),
                Wrap(
                  spacing: SizeConfig.padding / 2,
                  children: [
                    if (content?.deviceType != null &&
                        content?.deviceType != '')
                      AppText(
                        label: content?.deviceType ?? '',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (content?.loop != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (content?.loop != null)
                      AppText(
                        label: 'Loop : ${content?.loop}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (content?.deviceNumber != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (content?.deviceNumber != null)
                      AppText(
                        label: 'D : ${content?.deviceNumber}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (content?.zone != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (content?.zone != null)
                      AppText(
                        label: 'Zone : ${content?.zone}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (content?.olinet != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (content?.olinet != null)
                      AppText(
                        label: 'Panel : ${content!.olinet! + 1}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical / 2),
                AppText(
                  label: Utilities.formatSessionDate(content?.createdAt ?? ''),
                  style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.textFontSize,
                    fontColor: AppColors.lightFontColor(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
