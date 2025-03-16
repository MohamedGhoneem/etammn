import 'package:etammn/common/widgets/app_forward_icon.dart';
import 'package:etammn/utilities/constants/assets.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../common/widgets/app_text.dart';
import '../../../../utilities/constants/app_text_style.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../../change_language/bloc/change_language_bloc.dart';

class ButtonItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;
  final ChangeLanguageBloc changeLanguageBloc;
  final EdgeInsets? margin;

  const ButtonItemWidget(
      {Key? key, required this.iconPath, required this.title, this.onTap, required this.changeLanguageBloc, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin??EdgeInsets.symmetric(
            horizontal: SizeConfig.padding, vertical: SizeConfig.padding / 2),
        padding: EdgeInsets.all(SizeConfig.padding/2),
        decoration: BoxDecoration(
            color: AppColors.profileItemBGColor(),
            border: Border.all(
                color: AppColors.lightGreyColor.withOpacity(.4), width: 1),
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            AppImage(
              path: iconPath,
              width: SizeConfig.iconSize,
              height: SizeConfig.iconSize,
              color: AppColors.fontColor(),
            ),
            SizedBox(
              width: SizeConfig.padding,
            ),
            Expanded(
                child: AppText(
              label: title,
              style: AppTextStyle.style(
                  fontFamily: '',
                  fontSize: SizeConfig.titleFontSize,
                  fontColor: AppColors.fontColor()),
            )),
            AppForwardIcon(changeLanguageBloc: changeLanguageBloc,)
          ],
        ),
      ),
    );
  }
}
