import 'package:flutter/material.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';
import 'app_text.dart';

class AppExpandedRadioButton extends StatelessWidget {
  final Color activeColor;
  final Color? inactiveColor;
  final GestureTapCallback onTap;
  final String label;
  final double labelFontSize;
  final Color labelFontColor;
  final bool isSelected;

  const AppExpandedRadioButton(
      {Key? key,
      required this.activeColor,
      this.inactiveColor,
      required this.onTap,
      required this.label,
      required this.labelFontSize,
      required this.labelFontColor,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.padding / 2),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                label: label,
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: labelFontSize,
                    fontColor: labelFontColor),
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeVertical * 2),
            Container(
              width: SizeConfig.iconSize,
              height: SizeConfig.iconSize,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(
                      color: isSelected
                          ? activeColor
                          : inactiveColor ?? AppColors.greyColor,
                      width: 2),
                  shape: BoxShape.circle),
              padding: EdgeInsets.all(SizeConfig.padding / 4),
              child: Container(
                  width: SizeConfig.smallIconSize,
                  height: SizeConfig.smallIconSize,
                  decoration: BoxDecoration(
                      color: isSelected ? activeColor : AppColors.whiteColor,
                      shape: BoxShape.circle)),
            ),
          ],
        ),
      ),
    );
  }
}
