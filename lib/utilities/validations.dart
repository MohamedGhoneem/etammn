import 'package:rxdart/rxdart.dart';
import 'package:validators/validators.dart' as validator;

import '../common/widgets/phone_number_field/phone_number.dart';
import 'constants/constants.dart';
import 'localization/localizations.dart';

mixin Validations {
  isHasArabicChar(String value) {
    if (value.isNotEmpty) {
      return !RegExp(r"^[a-zA-Z-0-9-.-_.@.\s\']*$").hasMatch(value);
    }
    return false;
  }

  /// Password strategy min 8 digits
  /// min 1 numeric
  /// min 1 lowercase character
  /// min 1 uppercase character
  /// min 1 special character
  bool isPassword(String password) => RegExp(
        r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])([a-zA-Z0-9@$!%*?&]{8,})$",
        multiLine: false,
      ).hasMatch(password);

  String? validatePassword(String value) {
    if (validator.isNull(value) || value.length < 8 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).password} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }
  String? validateCurrentPassword(String value) {
    if (validator.isNull(value) || value.length < 8 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).currentPassword} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }
  String? validateEmail(String value) {
    final RegExp emailRegEx = RegExp(
        r'^(([^<>()[\]\\.,;:!@#$%&^*\s@\"]+(\.[^<>()[\]\\.,;:!@#$%&^*\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (validator.isNull(value) ||
        !emailRegEx.hasMatch(value) ||
        value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).email} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }

  String? validateUserName(String value) {
    if (validator.isNull(value) || value.length < 3 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).userName} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }

  String? validatePhoneNumber2(String value, [BehaviorSubject? subject]) {
    if (validator.isNull(value) ||
        !validator.isLength(value, 8, 11) ||
        value.isEmpty) {
      subject?.sink.add(
          '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).phoneNumber} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}');
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).phoneNumber} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }else {
      subject?.sink.add(null);
      return null;
    }
  }
  String? validatePhoneNumber(PhoneNumber? value) {
    // final RegExp regex = RegExp(r'^(?:\+|00)?[1-9]\d{11,14}$');
    try {
      // if (value == null ||
      //     // value.length != 11 ||
      value?.isValidNumber();
      // ) {
      //   return AppLocalizations
      //       .of(navigatorKey.currentState!.context)
      //       .enterValidPhoneNumber;
      // }
    }catch(e) {
      return AppLocalizations
          .of(AppConstants.navigatorKey.currentState!.context)
          .enterValidPhoneNumber;
    }
    return null;
  }
  String? validateFullName(String value) {
    if (validator.isNull(value) || value.length < 3 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).fullName} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }  String? validateSubject(String value) {
    if (validator.isNull(value) || value.length < 3 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).subject} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }  String? validateBody(String value) {
    if (validator.isNull(value) || value.length < 3 || value.isEmpty) {
      return '${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).enter} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).body} ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).correctly}';
    }
    return null;
  }
}
