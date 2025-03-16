import 'package:flutter/material.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';
import 'app_text.dart';

enum AppButtonAlign { start, center, centerStartIcon, centerEndIcon,end, none, expandedEndIcon, expandedStartIcon }

class AppButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final TextStyle? style;
  final Color borderColor;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final double? radius;
  final double? spaceBetween;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final AppButtonAlign? alignment;
  final InteractiveInkFeatureFactory? splashFactory;
  final RoundedRectangleBorder? roundedRectangleBorder;

  const AppButton(
      {Key? key,
      required this.title,
      this.icon,
      this.style,
      required this.borderColor,
      required this.backgroundColor,
      this.width,
      this.height,
      this.radius,
      this.spaceBetween,
      this.padding,
      this.margin,
      required this.onTap,
      this.alignment,
      this.splashFactory,
      this.roundedRectangleBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.btnHeight,
      width: width,
      margin: margin ?? EdgeInsets.zero,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: backgroundColor, padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          splashFactory: splashFactory ?? InkRipple.splashFactory,
          shape: roundedRectangleBorder ??
              RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 0.0))),
          side: BorderSide(color: borderColor, width: 1),
        ),
        autofocus: false,
        onPressed: onTap,
        child: Padding(padding: padding ?? EdgeInsets.zero, child: btn()),
      ),
    );
  }

  Widget btn() {
    if (icon != null && title.isEmpty) {
      return icon!;
    } else if (alignment != null) {
      switch (alignment!) {
        case AppButtonAlign.start:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null) icon!,
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
               _title(),
            ],
          );
        case AppButtonAlign.center:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              if (icon != null) icon!,
            ],
          );
        case AppButtonAlign.centerStartIcon:
        // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              _title(),
            ],
          );
        case AppButtonAlign.end:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              if (icon != null) icon!,
            ],
          );
        case AppButtonAlign.expandedStartIcon:
        // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon!,
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              Expanded(child: _title()),

            ],
          );
        case AppButtonAlign.expandedEndIcon:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: _title()),
              if (icon != null) icon!,
            ],
          );
        case AppButtonAlign.none:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              if (icon != null) icon!,
            ],
          );
        case AppButtonAlign.centerEndIcon:
          // TODO: Handle this case.
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              if (icon != null)
                SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
              if (icon != null) icon!,
            ],
          );
      }
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title(),
          if (icon != null)
            SizedBox(width: spaceBetween ?? SizeConfig.padding / 2),
          if (icon != null) icon!,
        ],
      );
    }
  }

  Widget _title() {
    return AppText(
      label: title,
      style: style ??
          AppTextStyle.style(
              fontFamily: Fonts.bold.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.primaryColor,
              textDecoration: TextDecoration.none),
    );
  }
}
