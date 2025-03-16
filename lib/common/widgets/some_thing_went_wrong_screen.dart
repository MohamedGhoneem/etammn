import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/constants/assets.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';
import 'app_button.dart';
import 'app_image.dart';

class SomeThingWentWrongScreen extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final TextAlign? textAlign;
  final VoidCallback retry;

  const SomeThingWentWrongScreen(
      {Key? key,
      required this.label,
      this.style,
      this.textAlign,
      required this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage(
          path: AppAssets.someThingWentWrong,
          width: SizeConfig.blockSizeHorizontal*60,
          height: SizeConfig.blockSizeHorizontal*40,
        ),
        SizedBox(
          height: SizeConfig.padding,
        ),
        Text(
          AppLocalizations.of(context).error,
          style: style ??
              AppTextStyle.style(
                  fontFamily: Fonts.bold.name,
                  fontSize: SizeConfig.titleFontSize,
                  fontColor: AppColors.fontColor()),
          textAlign: textAlign ?? TextAlign.start,
          maxLines: 1,
        ),
        SizedBox(
          height: SizeConfig.padding,
        ),
        Text(
          AppLocalizations.of(context).someThingWentWrong,
          style: style ??
              AppTextStyle.style(
                  fontFamily: Fonts.regular.name,
                  fontSize: SizeConfig.titleFontSize,
                  fontColor: AppColors.lightFontColor()),
          textAlign: textAlign ?? TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(
          height: SizeConfig.padding,
        ),

        AppButton(
            title: AppLocalizations.of(context).refresh,
            borderColor: AppColors.primaryColor,
            backgroundColor: AppColors.primaryColor,
            style: AppTextStyle.style(
                fontFamily: '',
                fontSize: SizeConfig.textFontSize,
                fontColor: AppColors.whiteColor),
            alignment: AppButtonAlign.centerStartIcon,
            width: SizeConfig.blockSizeHorizontal * 25,
            radius: SizeConfig.blockSizeHorizontal * 2,
          onTap: retry,
        ),

      ],
    );
  }
}
