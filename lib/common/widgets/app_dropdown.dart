import 'dart:convert';
import 'package:flutter/material.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';
import 'app_text.dart';

class AppDropdown<T> extends StatelessWidget {
  final String? title;
  final String titleKey;
  final String? hint;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged onChange;
  final FormFieldValidator<T> validator;
  final TextStyle? style;
  final Widget? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool? readOnly;

  const AppDropdown(
      {Key? key,
      this.title,
      required this.titleKey,
      this.hint,
      required this.items,
      this.selectedItem,
      required this.onChange,
      required this.validator,
      this.style,
      this.icon,
      this.iconColor,
      this.onTap,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      elevation: 3,
      isExpanded: false,
      value: selectedItem,
      validator: validator,
      // alignment: Alignment.bottomRight,
      dropdownColor: AppColors.backGroundColor(),
      hint: AppText(
        label: hint ?? '',
        style: style ??
            AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.fontColor(),
            ),
      ),
      style: AppTextStyle.style(
        fontFamily: Fonts.regular.name,
        fontSize: SizeConfig.textFontSize,
        fontColor: AppColors.fontColor(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8)),
      icon: icon ??
          Icon(
            Icons.keyboard_arrow_down,
            size: SizeConfig.iconSize,
            color: iconColor ?? AppColors.fontColor(),
          ),
      onTap: onTap,
      items: items.map((T data) {
        var map = Map<String, dynamic>.from(json.decode(json.encode(data)));
        return DropdownMenuItem(
          value: data,
          child: AppText(
            label: '${map['flag'] ?? ''} ${map[titleKey]}',
            style: style ??
                AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.textFontSize,
                    fontColor: AppColors.fontColor(),
                    textDecoration: TextDecoration.none),
          ),
        );
      }).toList(),
      onChanged: readOnly == true ? null : onChange,
    );
  }
}
