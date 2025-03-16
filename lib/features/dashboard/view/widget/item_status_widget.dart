import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/common/models/system_item_model.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../model/dashboard_respons_model.dart';

class ItemStatusWidget extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final String? text;
  final String? count;
  final Color? bgColor;
  final Color? fontColor;
  final TextAlign? textAlign;

  const ItemStatusWidget(
      {Key? key,
      this.iconPath,
      this.title,
      this.text,
      this.count,
      this.bgColor,
      this.fontColor,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          label: title ?? '',
          style: AppTextStyle.style(
              fontFamily: '',
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.greyColor),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.padding / 2, vertical: SizeConfig.padding),
          decoration: BoxDecoration(
              color: bgColor?.withOpacity(.1),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
          child: Row(
            children: [
              if (iconPath != null)
                AppImage(
                  path: iconPath ?? '',
                  width: SizeConfig.iconSize,
                  height: SizeConfig.iconSize,
                  color: bgColor,
                ),
              if (iconPath != null)
                SizedBox(
                  width: SizeConfig.padding / 3,
                ),
              Expanded(
                  child: AppText(
                label: text ?? '',
                style: AppTextStyle.style(
                  fontFamily: '',
                  fontSize: SizeConfig.textFontSize,
                  fontColor: fontColor ?? AppColors.fontColor(),
                ),
                textAlign: textAlign,
              )),
              if (count != null)
                AppText(
                  label: count ?? '',
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.fontColor()),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
