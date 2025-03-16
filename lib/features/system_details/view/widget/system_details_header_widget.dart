import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/system_contacts/bloc/system_contacts_bloc.dart';
import 'package:etammn/features/system_contacts/view/system_contacts_view.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/models/user_model.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../common/widgets/app_text.dart';
import '../../../../utilities/constants/app_text_style.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/localization/localizations.dart';
import '../../../../utilities/size_config.dart';
import '../../../dashboard/view/widget/item_status_widget.dart';
import '../../../users/view/users_view.dart';
import '../../model/system_details_response_model.dart';

class SystemDetailsHeaderWidget extends StatelessWidget {
  final SystemDetailsResponseModel? content;
  final SystemDetailsBloc bloc;

  const SystemDetailsHeaderWidget(
      {Key? key, required this.content, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.padding),
        Row(
          children: [
            Column(
              children: [
                AppButton(
                    title: '',
                    borderColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor,
                    icon: AppImage(
                      path: AppAssets.users,
                      width: SizeConfig.iconSize,
                      height: SizeConfig.iconSize,
                      color: AppColors.whiteColor,
                    ),
                    width: SizeConfig.iconSize * 2,
                    height: SizeConfig.iconSize * 2,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    onTap: () => Utilities.navigate(const UsersView(
                          showBackButton: true,
                        ))),
                SizedBox(
                  height: SizeConfig.padding / 2,
                ),
                AppText(
                  label: AppLocalizations.of(context).users,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.smallTextFontSize,
                      fontColor: AppColors.fontColor()),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (content?.data?.isOnline != null &&
                            content?.data?.isOnline != false)
                          StreamBuilder<bool>(
                              stream: bloc.alarmSubject,
                              builder: (context, snapshot) {
                                Color fontColor;
                                if (content?.data?.currentStatus?.name
                                        ?.toLowerCase() ==SystemCurrentStatusEnum.fire.name
                                    ) {
                                  fontColor = AppColors.redColor;
                                } else if (content?.data?.currentStatus?.name
                                        ?.toLowerCase() ==SystemCurrentStatusEnum.faulty.name
                                ) {
                                  fontColor = AppColors.faultsColor;
                                } else {
                                  fontColor = AppColors.resetBtnColor;
                                }
                                return snapshot.hasData
                                    ? AppButton(
                                        title:
                                            content?.data?.currentStatus?.localizedName ?? '',
                                        radius: SizeConfig.padding,
                                        height: SizeConfig.iconSize * 2,
                                        style: AppTextStyle.style(
                                          fontFamily: '',
                                          fontSize: SizeConfig.textFontSize,
                                          fontColor: snapshot.data == true
                                              ? AppColors.whiteColor
                                              : fontColor,
                                        ),
                                        borderColor: AppColors.transparentColor,
                                        backgroundColor: snapshot.data == true
                                            ? fontColor
                                            : AppColors.transparentColor,
                                        onTap: null,
                                      )
                                    : const SizedBox();
                              }),
                        const Spacer(),
                        AppText(
                          label: content?.data?.isOnline != null &&
                                  content?.data?.isOnline != false
                              ? AppLocalizations.of(context).online
                              : AppLocalizations.of(context).offline,
                          style: AppTextStyle.style(
                            fontFamily: '',
                            fontSize: SizeConfig.textFontSize,
                            fontColor: content?.data?.isOnline == true
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
                              color: content?.data?.isOnline == true
                                  ? AppColors.greenColor
                                  : AppColors.redColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.btnRadius))),
                        ),
                      ],
                    ),
                    AppText(
                      label: content?.data?.location?.buildingName ?? '',
                      style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.bigTitleFontSize,
                          fontColor: AppColors.fontColor()),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                AppButton(
                    title: '',
                    borderColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor,
                    icon: SvgPicture.asset(
                      AppAssets.mobile,
                      width: SizeConfig.iconSize,
                      height: SizeConfig.iconSize,
                      color: AppColors.whiteColor,
                    ),
                    width: SizeConfig.iconSize * 2,
                    height: SizeConfig.iconSize * 2,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    onTap: () => Utilities.navigate(BlocProvider(
                        bloc: SystemContactsBloc(systemId: content?.data?.id),
                        child: const SystemContactsView()))),
                SizedBox(
                  height: SizeConfig.padding / 2,
                ),
                AppText(
                  label: AppLocalizations.of(context).contacts,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.smallTextFontSize,
                      fontColor: AppColors.fontColor()),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
        AppButton(
            title: '${content?.data?.location?.country?.name} / ${content?.data?.location?.district?.name}' ?? '',
            borderColor: AppColors.lightGreyColor.withOpacity(.4),
            backgroundColor: AppColors.lightGreyColor.withOpacity(.4),
            alignment: AppButtonAlign.centerStartIcon,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding * 2),
            height: SizeConfig.btnHeight / 3 * 2,
            style: AppTextStyle.style(
              fontFamily: '',
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.fontColor(),
            ),
            radius: SizeConfig.btnRadius,
            icon: Icon(
              Icons.location_on_rounded,
              color: AppColors.fontColor(),
              size: SizeConfig.smallIconSize,
            ),
            onTap: () => Utilities.launchMaps(content?.data?.location?.latitude,
                content?.data?.location?.longitude)),
        SizedBox(
          height: SizeConfig.padding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ItemStatusWidget(
                iconPath: AppAssets.fire,
                title: '',
                text: AppLocalizations.of(context).fire,
                count: content?.data?.isOnline == true
                    ? content?.data?.alarmCount.toString()
                    : '0',
                bgColor: AppColors.primaryColor,
                fontColor: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              width: SizeConfig.padding / 2,
            ),
            Expanded(
              child: ItemStatusWidget(
                iconPath: AppAssets.faults,
                title: '',
                text: AppLocalizations.of(context).faults,
                count: content?.data?.isOnline == true
                    ? content?.data?.faultCount.toString()
                    : '0',
                bgColor: AppColors.faultsColor,
                fontColor: AppColors.faultsColor,
              ),
            ),
            SizedBox(
              width: SizeConfig.padding / 2,
            ),
            // Event Type Status
            content?.data?.isOnline == true
                ? Expanded(
                    child: ItemStatusWidget(
                      title: AppLocalizations.of(context).currentMode,
                      text: content?.data?.currentMode?.localizedName,
                      bgColor: AppColors.lightGreyColor,
                      fontColor: AppColors.blueColor,
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }
}
