import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';
import 'app_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final TextAlign? textAlign;
  final VoidCallback retry;

  const AppErrorWidget(
      {Key? key,
      required this.label,
      this.style,
      this.textAlign,
      required this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: retry,
          child: Icon(
            Icons.refresh,
            color: AppColors.primaryColor,
            size: SizeConfig.iconSize*2,
          ),
        ),
        // SizedBox(
        //   width: SizeConfig.padding,
        // ),
        // Expanded(
        //   child: Text(
        //     label,
        //     style: style ??
        //         AppTextStyle.style(
        //             fontFamily: Fonts.bold.name,
        //             fontSize: SizeConfig.textFontSize,
        //             fontColor: AppColors.primaryColor),
        //     textAlign: textAlign ?? TextAlign.start,
        //     maxLines: 3,
        //   ),
        // ),
        // AppButton(
        //     title: '',
        //     borderColor: AppColors.transparentColor,
        //     backgroundColor: AppColors.transparentColor,
        //     icon: SvgPicture.asset(
        //       AppAssets.retry,
        //       width: SizeConfig.iconSize,
        //       height: SizeConfig.iconSize,
        //       color: AppColors.accentColor,
        //     ),
        //     onTap: retry)
      ],
    );
  }
}
