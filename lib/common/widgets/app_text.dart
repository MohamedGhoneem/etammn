import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';

class AppText extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
      {Key? key,
      required this.label,
      this.style,
      this.textAlign,
      this.maxLines,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style ??
          AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.fontColor(),
              textDecoration: TextDecoration.none),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
