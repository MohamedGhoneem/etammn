import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';

class AppEmptyList extends StatelessWidget {
  final String message;

  const AppEmptyList({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      message,
      style: AppTextStyle.style(
      fontFamily: Fonts.bold.name,
      fontSize: SizeConfig.textFontSize, fontColor: AppColors.primaryColor),
    );
  }
}
