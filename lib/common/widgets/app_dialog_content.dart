import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/localization/localizations.dart';
import '../../utilities/size_config.dart';
import 'app_button.dart';
import 'app_text.dart';

class AppDialogContent extends StatelessWidget {
  final String? title;
  final Widget? alertIcon;
  final String description;
  final String? okButtonTitle;
  final String? cancelButtonTitle;
  final VoidCallback? okBtnTapped;
  final VoidCallback? cancelBtnTapped;

   AppDialogContent(
      {Key? key,
      this.title,
      this.alertIcon,
      required this.description,
      this.okButtonTitle,
      this.cancelButtonTitle,
      this.okBtnTapped,
      this.cancelBtnTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.padding * 2,
                vertical: SizeConfig.padding * 5),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.padding, vertical: SizeConfig.padding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.whiteColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      label: title ?? AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).alert,
                      style: AppTextStyle.style(
                          fontFamily: Fonts.regular.name,
                          fontSize: SizeConfig.titleFontSize,
                          fontColor: AppColors.primaryColor,textDecoration: TextDecoration.none),
                    ),
                    alertIcon ?? const SizedBox()
                  ],
                ),
                SizedBox(height: SizeConfig.padding),
                AppText(
                  label: description,
                  style: AppTextStyle.style(
                      fontFamily: Fonts.regular.name,
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.primaryColor,textDecoration: TextDecoration.none),
                ),
                SizedBox(height: SizeConfig.padding * 2),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppButton(
                          width: double.infinity,
                          height: SizeConfig.btnHeight-5,
                          style: AppTextStyle.style(
                              fontFamily: Fonts.semiBold.name,
                              fontSize: SizeConfig.titleFontSize,
                              fontColor: AppColors.whiteColor),
                          title:
                              okButtonTitle ?? AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).ok,
                          borderColor: AppColors.primaryColor,
                          backgroundColor: AppColors.primaryColor,radius: SizeConfig.btnRadius,
                          onTap: okBtnTapped ?? () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    if (cancelBtnTapped != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AppButton(
                            width: double.infinity,
                            height: SizeConfig.btnHeight-5,
                            style: AppTextStyle.style(
                                fontFamily: Fonts.semiBold.name,
                                fontSize: SizeConfig.titleFontSize,
                                fontColor: AppColors.whiteColor),
                            title: cancelButtonTitle ?? '',
                            borderColor: AppColors.blueColor,
                            backgroundColor: AppColors.blueColor,radius: SizeConfig.btnRadius,
                            onTap:
                                cancelBtnTapped ?? () => Navigator.pop(context),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: SizeConfig.padding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
