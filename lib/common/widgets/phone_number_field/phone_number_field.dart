import 'dart:async';

import 'package:etammn/common/widgets/phone_number_field/phone_number.dart';
import 'package:etammn/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import 'countries.dart';
import 'intl_phone_field.dart';
class PhoneNumberField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final BehaviorSubject<PhoneNumber?> subject;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final bool? disableLengthCheck;
  final Color? fillColor;
  final Color? boarderColor;
  final Color? textColor;
  final String? languageCode;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? errorBorderColor;
  final double? boarderRadius;
  final AutovalidateMode autovalidateMode;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final BehaviorSubject<bool>? isValidPhone;


  const PhoneNumberField({Key? key,
    required this.controller,
    required this.subject,
    required this.onChanged,
    required this.onCountryChanged,
    this.label,
    this.disableLengthCheck,
    this.fillColor,
    this.boarderColor,
    this.textColor,
    this.languageCode,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.focusedErrorBorderColor,
    this.errorBorderColor,
    this.boarderRadius,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validator,
    this.isValidPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PhoneNumber?>(
        stream: subject,
        builder: (context, snapshot) {
          debugPrint("PHONE ==== ${snapshot.data}");
          return snapshot.hasData
              ? Directionality(
                  textDirection: TextDirection.ltr,
                  child: StreamBuilder<bool>(
                      stream: isValidPhone,
                      builder: (context, validationSnapshot) {
                        debugPrint("PHONE validationSnapshot ==== ${validationSnapshot.data}");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntlPhoneField(
                              autofocus: false,
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: '',
                                counterStyle: TextStyle(
                                    color: textColor ?? AppColors.hintColor),
                                errorStyle: TextStyle(
                                    fontSize:
                                        SizeConfig.smallTextFontSize,
                                    color: Colors.red),
                                fillColor:
                                    fillColor ?? Colors.transparent,
                                filled: true,
                                counter: const SizedBox(),
                                border: validationSnapshot.data ?? false
                                    ? OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: boarderColor ??
                                                AppColors.borderColor,
                                            width:
                                                SizeConfig.borderWidth),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      )
                                    : OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: errorBorderColor ??
                                                AppColors.redColor,
                                            width:
                                                SizeConfig.borderWidth),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                enabledBorder: validationSnapshot.data ?? false
                                    ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: enabledBorderColor ?? AppColors.borderColor,
                                      width: SizeConfig.borderWidth),
                                  borderRadius: BorderRadius.circular(8),
                                ) : OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: errorBorderColor ??
                                                AppColors.redColor,
                                            width:
                                                SizeConfig.borderWidth),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                focusedBorder: validationSnapshot.data ?? false
                                    ? OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: focusedBorderColor ?? AppColors.borderColor,
                                      width: SizeConfig.borderWidth),
                                  borderRadius: BorderRadius.circular(8),
                                ) : OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: errorBorderColor ??
                                                AppColors.redColor,
                                            width:
                                                SizeConfig.borderWidth),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: errorBorderColor ?? AppColors.redColor,
                                      width: SizeConfig.borderWidth),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: errorBorderColor ?? AppColors.redColor,
                                      width: SizeConfig.borderWidth),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              languageCode: languageCode ?? "en",
                              initialValue: snapshot.data?.number,
                              // decoration: const InputDecoration(
                              //   border: InputBorder.none,
                              //   counterText: '',
                              //   contentPadding: EdgeInsets.zero,
                              //   // floatingLabelAlignment:
                              //   // FloatingLabelAlignment.center
                              // ),
                              style: TextStyle(
                                  color: textColor ?? AppColors.hintColor),
                              textAlignVertical: TextAlignVertical.center,
                              initialCountryCode:
                                  snapshot.data?.countryISOCode,
                              onChanged: onChanged,
                              onCountryChanged: onCountryChanged,
                              autovalidateMode: autovalidateMode,
                              disableLengthCheck:
                                  disableLengthCheck ?? true,
                              dropdownIcon:  Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.hintColor,
                              ),
                              dropdownTextStyle:
                                  TextStyle(color: textColor),
                              searchText: AppLocalizations.of(context).searchCountry,
                              invalidNumberMessage:
                                  AppLocalizations.of(context).enterValidPhoneNumber,
                              // validator: validator ?? (number){
                              //   try {
                              //     debugPrint("PHONE ====22 ${snapshot.data}");
                              //     number?.isValidNumber();
                              //   }catch(e) {
                              //     debugPrint("PHONE ====22 ${snapshot.data}");
                              //     return AppLocalizations
                              //         .of(context)
                              //         .enterValidPhoneNumber;
                              //   }
                              //   debugPrint("PHONE ====33 ${snapshot.data}");
                              //   return null;
                              // },
                            ),
                            //  Visibility(
                            //         visible: isRegister != true && ((validator?.call(snapshot.data) !=
                            //             null && autovalidateMode == AutovalidateMode.disabled) || (snapshot.data?.number.isEmpty == true && !(validationSnapshot.data ?? false))),
                            //         child: Text(
                            //           AppLocalizations.of(context)
                            //               .enterValidPhoneNumber,
                            //           style: TextStyle(
                            //               fontSize:
                            //                   SizeConfig.smallTextFontSize,
                            //               color: Colors.red),
                            //         )
                            // )
                             Visibility(
                                    visible:!(validationSnapshot.data ?? false),
                                    child: Text(
                                      AppLocalizations.of(context).enterValidPhoneNumber,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.smallTextFontSize,
                                          color: Colors.red),
                                    )
                            )
                          ]);
                    }
                  ))
              : const SizedBox();
        });
  }
}
