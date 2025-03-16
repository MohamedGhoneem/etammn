import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../model/system_contacts_response_model.dart';

class SystemContactsItemWidget extends StatelessWidget {
  final SystemContactModel? content;

  const SystemContactsItemWidget({Key? key, required this.content}) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  label: content?.name ?? '',
                  style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.fontColor(),
                  ),
                ),
              ),
              AppButton(
                  title: content?.country?.name ?? '',
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
                  onTap: null),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: content?.mobile ?? '',
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  alignment: AppButtonAlign.start,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.fontColor()),
                  icon: SvgPicture.asset(
                    AppAssets.mobile,
                    height: SizeConfig.iconSize,
                    width: SizeConfig.iconSize,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Utilities.socialMediaBtnTapped(
                      SocialType.PHONE, content?.mobile ?? ''),
                ),
              ),
              Expanded(
                child: AppButton(
                  title: content?.landline ?? '',
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  alignment: AppButtonAlign.start,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.fontColor()),
                  icon: SvgPicture.asset(
                    AppAssets.mobile,
                    height: SizeConfig.iconSize,
                    width: SizeConfig.iconSize,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Utilities.socialMediaBtnTapped(
                      SocialType.PHONE, content?.landline ?? ''),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
