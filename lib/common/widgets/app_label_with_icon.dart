import 'package:flutter/material.dart';

import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';
import 'app_text.dart';

class AppLabelWithIcon extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Widget icon;
  final double? fontSize;

  const AppLabelWithIcon(
      {Key? key,
      required this.label,
      required this.labelColor,
      required this.icon,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          label: label,
          style: AppTextStyle.style(
              fontFamily: Fonts.regular.name,fontSize:
              fontSize ?? SizeConfig.textFontSize,fontColor: labelColor),
        ),
        SizedBox(width: SizeConfig.blockSizeHorizontal/2),
        icon,
      ],
    );
  }
}
