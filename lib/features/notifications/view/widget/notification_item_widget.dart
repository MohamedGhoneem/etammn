import 'dart:convert';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../model/notification_data_model.dart';
import '../../model/notifications_response_model.dart';

class NotificationItemWidget extends StatefulWidget {
  final NotificationData? content;

  const NotificationItemWidget(
      {Key? key, required this.content})
      : super(key: key);

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  NotificationDataModel? notificationDataModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationDataModel = NotificationDataModel.fromJson(
        json.decode(widget.content?.data.toString() ?? ''));
  }

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
            path:
                widget.content?.sound?.toLowerCase() == 'fire'
                ? AppAssets.fire
                : AppAssets.faults,
            width: SizeConfig.iconSize,
            height: SizeConfig.iconSize,
            boxFit: BoxFit.fill,
            isCircular: true,
          ),
          // Image.memory(
          //   bytes,
          //   width: SizeConfig.blockSizeHorizontal * 20,
          //   height: SizeConfig.blockSizeHorizontal * 20,
          // ),
          SizedBox(width: SizeConfig.padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label: notificationDataModel?.eventType == '***'
                      ? widget.content?.body??''
                      : notificationDataModel?.eventType ?? '',
                  style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.fontColor(),
                  ),
                ),
                if (widget.content?.buildingName != null &&
                    widget.content?.buildingName != '')
                  AppText(
                    label: widget.content?.buildingName ?? '',
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.fontColor(),
                    ),
                  ),
                if (notificationDataModel?.textLocation != null &&
                    notificationDataModel?.textLocation != '')
                  SizedBox(height: SizeConfig.blockSizeVertical / 2),
                if (notificationDataModel?.textLocation != null &&
                    notificationDataModel?.textLocation != '')
                  AppText(
                    label: notificationDataModel?.textLocation ?? '',
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.lightFontColor(),
                    ),
                  ),
                // if (notificationDataModel?.deviceType != null &&
                //     notificationDataModel?.deviceType != '')
                //   SizedBox(height: SizeConfig.blockSizeVertical / 2),
                // if (notificationDataModel?.deviceType != null &&
                //     notificationDataModel?.deviceType != '')
                //   AppText(
                //     label: notificationDataModel?.deviceType ?? '',
                //     style: AppTextStyle.style(
                //       fontFamily: '',
                //       fontSize: SizeConfig.textFontSize,
                //       fontColor: AppColors.lightFontColor(),
                //     ),
                //   ),
                SizedBox(height: SizeConfig.blockSizeVertical / 2),
                Wrap(
                  spacing: SizeConfig.padding / 2,
                  children: [
                    if (notificationDataModel?.deviceType != null &&
                        notificationDataModel?.deviceType != '')
                      AppText(
                        label: notificationDataModel?.deviceType ?? '',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (notificationDataModel?.loop != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (notificationDataModel?.loop != null)
                      AppText(
                        label: 'Loop : ${notificationDataModel?.loop}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (notificationDataModel?.deviceNumber != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (notificationDataModel?.deviceNumber != null)
                      AppText(
                        label: 'D : ${notificationDataModel?.deviceNumber}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (notificationDataModel?.zone != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (notificationDataModel?.zone != null)
                      AppText(
                        label: 'Zone : ${notificationDataModel?.zone}',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.lightFontColor(),
                        ),
                      ),
                    if (notificationDataModel?.olinet != null)
                      AppText(
                        label: '|',
                        style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.primaryColor,
                        ),
                      ),
                    if (notificationDataModel?.olinet != null)
                      AppText(
                        label: 'Panel : ${int.parse(notificationDataModel!.olinet.toString()) + 1 }',
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
                  label: Utilities.formatSessionDate(
                      widget.content?.createdAt ?? ''),
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
