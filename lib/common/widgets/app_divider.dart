import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';

class AppDivider extends StatelessWidget {
  final EdgeInsets? dividerPadding;
  final double? thickness;
  final double? dividerHeight;
  final Color? dividerColor;

  const AppDivider({Key? key,this.dividerPadding, this.thickness, this.dividerHeight, this.dividerColor}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return divider();
  }

  Widget divider() {
    return Padding(
      padding: dividerPadding ??
          EdgeInsets.only(top: SizeConfig.padding, bottom: SizeConfig.padding),
      child: Divider(
        height: dividerHeight ?? 1,
        thickness: thickness??1,
        color: dividerColor ?? AppColors.lightGreyColor.withOpacity(.3),
      ),
    );
  }
}
