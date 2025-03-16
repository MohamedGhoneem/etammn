import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../utilities/constants/assets.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/size_config.dart';
import '../../utilities/validations.dart';

enum AppFormFieldItemType {
  email,
  password,
  number,
  text,
  phone,
  multiText,
  userName,
  userNameOrEmail,
  firstName,
  lastName,
  search,
}

class AppTextFormFieldItem extends StatelessWidget with Validations {
  final TextEditingController? controller;
  final String title;
  final AppFormFieldItemType formFieldItemType;
  final BehaviorSubject subject;
  final BehaviorSubject<bool>? obscureTextSubject;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final Color? fontColor;
  final Widget? label;
  final Widget? prefixIcon;
  final Color labelFontColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color? cursorColor;
  final Color iconColor;
  final Color focusedIconColor;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool? showHint;
  final bool? showUnderLine;
  final bool? readOnly;
  final bool? autofocus;
  final EdgeInsets? contentPadding;
  final VoidCallback? submit;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const AppTextFormFieldItem({
    this.controller,
    required this.title,
    required this.formFieldItemType,
    required this.subject,
    this.obscureTextSubject,
    this.focusNode,
    required this.textInputType,
    this.fontColor,
    this.label,
    this.prefixIcon,
    required this.labelFontColor,
    required this.borderColor,
    required this.focusedBorderColor,
    this.cursorColor,
    required this.iconColor,
    required this.focusedIconColor,
    this.maxLines,
    this.onTap,
    this.validator,
    this.showHint = false,
    this.showUnderLine = false,
    this.readOnly = false,
    this.autofocus = false,
    this.contentPadding,
    this.submit,
    this.onChanged,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: subject.stream,
        builder: (context, snapshot) {
          return formFieldItemType == AppFormFieldItemType.password &&
                  obscureTextSubject != null
              ? StreamBuilder(
                  stream: obscureTextSubject!.stream,
                  builder: (context, obscureTextSnapshot) {
                    return passwordTextFormField(
                        context: context,
                        obscureTextSnapshot:
                            obscureTextSnapshot.data == true ? true : false);
                  })
              : textFormField(context: context);
        });
  }

  TextFormField passwordTextFormField(
      {required BuildContext context, required bool obscureTextSnapshot}) {
    return TextFormField(
        onTap: onTap,
        controller: controller,
        cursorColor: cursorColor,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        maxLines: 1,
        maxLength: maxLength,
        style: AppTextStyle.style(
            fontFamily: Fonts.regular.name,
            fontSize: SizeConfig.textFontSize,
            fontColor: fontColor ?? AppColors.fontColor()),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: formFieldItemType == AppFormFieldItemType.password &&
            obscureTextSubject!.value
            ? true
            : false,
        keyboardType: textInputType,
        onChanged: onChanged ??
                (String input) {
              subject.sink.add(input);
            },
        decoration: InputDecoration(
          prefixIcon: prefixIcon??const SizedBox(),
          suffixIcon: formFieldItemType == AppFormFieldItemType.password
              ? IconButton(
                  onPressed: () {
                    log(obscureTextSubject!.value.toString());
                    obscureTextSubject!.sink
                        .add(!obscureTextSubject!.value);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.eye,
                    color: obscureTextSnapshot
                        ? borderColor
                        : focusedBorderColor,
                    width: SizeConfig.iconSize,
                    height: SizeConfig.iconSize,
                  ))
              : const SizedBox(width: 0, height: 20),
          focusedBorder: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: focusedBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          enabledBorder: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          border: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          errorBorder: showUnderLine == true
              ? const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor))
              : OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          focusedErrorBorder: showUnderLine == true
              ? const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor))
              : OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          contentPadding: EdgeInsets.all(SizeConfig.padding*1.2),
          labelStyle: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: labelFontColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: label,
          hintText: showHint == true ? title : '',
          hintStyle: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: labelFontColor),
          errorText: subject.hasError ? subject.stream.error.toString() : null,
          errorStyle: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.smallTextFontSize,
              fontColor: AppColors.redColor),
        ),
        onEditingComplete: submit,
        validator: validator);
  }

  TextFormField textFormField({required BuildContext context}) {
    return TextFormField(

        onTap: onTap,
        controller: controller,
        cursorColor: cursorColor,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        readOnly: readOnly ?? false,
        maxLines:
        formFieldItemType == AppFormFieldItemType.multiText ? maxLines : 1,
        maxLength: maxLength,
        style: AppTextStyle.style(
            fontFamily: Fonts.regular.name,
            fontSize: SizeConfig.textFontSize,
            fontColor: fontColor ?? AppColors.fontColor()),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: formFieldItemType == AppFormFieldItemType.password &&
            obscureTextSubject!.value
            ? true
            : false,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged ??
                (String input) {
              subject.sink.add(input);
            },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
       //   suffixIcon: const SizedBox(width: 0, height: 20),
          focusedBorder: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: focusedBorderColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          enabledBorder: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          border: showUnderLine == true
              ? UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: labelFontColor))
              : OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          errorBorder: showUnderLine == true
              ? const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor))
              : OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          focusedErrorBorder: showUnderLine == true
              ? const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor))
              : OutlineInputBorder(
              borderSide:
              const BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.btnRadius / 2))),
          contentPadding: contentPadding ?? EdgeInsets.all(SizeConfig.padding*1.2),
          labelStyle: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: labelFontColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: label,
          hintText: showHint == true ? title : '',
          hintStyle: AppTextStyle.style(
            fontFamily: Fonts.regular.name,
            fontSize: SizeConfig.textFontSize,
            fontColor: labelFontColor,
          ),
          errorText: subject.hasError ? subject.stream.error.toString() : null,
          errorStyle: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.smallTextFontSize,
              fontColor: AppColors.redColor),
          isCollapsed: true,
          isDense: true,counterText: ''
        ),
        onEditingComplete: submit,
        validator: validator);
  }
}
