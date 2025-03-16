import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';

class AppContainerWithLabel extends StatelessWidget {
  final Color borderColor;
  final Widget child;
  final Widget label;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppContainerWithLabel(
      {Key? key,
      required this.borderColor,
      required this.label,
      required this.child,
      this.width,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: borderColor),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.btnRadius/2))),
          padding: padding ?? EdgeInsets.symmetric(horizontal: SizeConfig.padding / 4),
          child: child,
        ),
        Positioned(
          top: -9,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding-4 ),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: AppColors.whiteColor,
                child: label),
          ),
        ),
      ],
    );
  }
}
