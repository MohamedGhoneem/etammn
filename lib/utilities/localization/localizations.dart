import 'dart:async';
import 'dart:ui';

import 'l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return  AppLocalizations();
    });
  }

  String get locale => Intl.message('ar', name: 'locale');

  String get title => Intl.message('Etammn', name: 'title');

  String get arabicLanguage => Intl.message('عربي', name: 'arabic');

  String get englishLanguage => Intl.message('English', name: 'english');

  String get noInternetConnection =>
      Intl.message('Please check your internet connection', name: 'noInternetConnection');

  String get logout => Intl.message('Log out', name: 'logout');

  String get continueLogout =>
      Intl.message('Continue log out', name: 'continueLogout');

  String get alert => Intl.message('Alert', name: 'alert');

  String get ok => Intl.message('Confirm', name: 'ok');

  String get cancel => Intl.message('Cancel', name: 'cancel');

  String get back => Intl.message('Back', name: 'back');

  String get userName => Intl.message('اسم المستخدم', name: 'userName');

  String get email => Intl.message('Email', name: 'email');

  String get phoneNumber => Intl.message('Mobile', name: 'phoneNumber');

  String get password => Intl.message('Password', name: 'password');

  String get confirmPassword => Intl.message('Confirm password', name: 'confirmPassword');
  String get dashboard => Intl.message('Dashboard', name: 'dashboard');
  String get users => Intl.message('Users', name: 'users');
  String get notifications => Intl.message('Notifications', name: 'notifications');
  String get menu => Intl.message('Menu', name: 'menu');
  String get enter => Intl.message('Enter', name: 'enter');
  String get correctly => Intl.message('Correctly', name: 'correctly');
  String get login => Intl.message('LOGIN', name: 'login');
  String get incorrectMobileNumberOrPassword => Intl.message('Incorrect mobile number or password', name: 'incorrectMobileNumberOrPassword');
  String get forgotPassword => Intl.message('FORGOT PASSWORD?', name: 'forgotPassword');
  String get send => Intl.message('SEND', name: 'send');
  String get confirm => Intl.message('CONFIRM', name: 'confirm');
  String get codeSentToEmail => Intl.message('Verification code has been sent to your email address.', name: 'codeSentToEmail');
  String get didNotGetCode => Intl.message('You didn\'t get code!', name: 'didNotGetCode');
  String get sendItAgain => Intl.message('Send it again', name: 'sendItAgain');
  String get passwordMismatch => Intl.message('Password Mismatch', name: 'passwordMismatch');
  String get currentPassword => Intl.message('Current Password', name: 'currentPassword');
  String get newPassword => Intl.message('New Password', name: 'newPassword');
  String get confirmNewPassword => Intl.message('Confirm New Password', name: 'confirmNewPassword');
  String get currentMode => Intl.message('Current mode', name: 'currentMode');
  String get myProfile => Intl.message('My profile', name: 'myProfile');
  String get pauseNotification => Intl.message('Mute Faults Notification', name: 'pauseNotification');
  String get darkMode => Intl.message('Dark mode', name: 'darkMode');
  String get language => Intl.message('Language', name: 'language');
  String get helpCenter => Intl.message('Help Center, FAQ\'s', name: 'helpCenter');
  String get privacyPolicy => Intl.message('Privacy Policy', name: 'privacyPolicy');
  String get termsOfUse => Intl.message('Terms of Use', name: 'termsOfUse');
  String get addUser => Intl.message('Add User', name: 'addUser');
  String get addUserImage => Intl.message('Add user photo', name: 'addUserImage');
  String get editUser => Intl.message('Edit user', name: 'editUser');
  String get changePassword => Intl.message('Change password', name: 'changePassword');
  String get systemDetails => Intl.message('System Details', name: 'systemDetails');
  String get reports => Intl.message('Reports', name: 'reports');
  String get silent => Intl.message('Silent', name: 'silent');
  String get mute => Intl.message('Mute', name: 'mute');
  String get reset => Intl.message('Reset', name: 'reset');
  String get changeMode => Intl.message('Change mode', name: 'changeMode');
  String get selectMode => Intl.message('Select mode', name: 'selectMode');
  String get live => Intl.message('Live', name: 'live');
  String get maintenance => Intl.message('Maintenance', name: 'maintenance');
  String get bokhoor => Intl.message('Bokhoor', name: 'bokhoor');
  String get contacts => Intl.message('Contacts', name: 'contacts');
  String get activeEvents => Intl.message('Active Events', name: 'activeEvents');
  String get eventsLogs => Intl.message('Events Logs', name: 'eventsLogs');
  String get deleteUser => Intl.message('Delete User', name: 'deleteUser');
  String get continueDeleting => Intl.message('Continue deleting user', name: 'continueDeleting');
  String get allowedSystems => Intl.message('Allowed Systems', name: 'allowedSystems');
  String get errorWhileUploading => Intl.message('Error While Uploading', name: 'errorWhileUploading');
  String get noDataFound => Intl.message('No Data Found', name: 'noDataFound');
  String get control => Intl.message('Control', name: 'control');
  String get usersControl => Intl.message('Users Control', name: 'usersControl');
  String get addSystems => Intl.message('You have to add at least 1 system', name: 'addSystems');
  String get fire => Intl.message('Fire', name: 'fire');
  String get faults => Intl.message('Faults', name: 'faults');
  String get clickTwice => Intl.message('To close Etammn App, click twice on back button.', name: 'clickTwice');
  String get youHaveNoAccessForRemoteControl => Intl.message('You have no access for remote control', name: 'youHaveNoAccessForRemoteControl');
  String get noNewEvents => Intl.message('No New Events', name: 'noNewEvents');
  String get selectDuration => Intl.message('Select Duration', name: 'selectDuration');
  String get extendMessage => Intl.message('Are you sure you want to end this mode on time?', name: 'extendMessage');
  String get extend => Intl.message('Extend', name: 'extend');
  String get online => Intl.message('Online', name: 'online');
  String get offline => Intl.message('Offline', name: 'offline');
  String get evacuation => Intl.message('Evacuate', name: 'evacuation');
  String get error => Intl.message('Error', name: 'error');
  String get refresh => Intl.message('Refresh', name: 'refresh');
  String get someThingWentWrong => Intl.message('oops something went wrong! \nPlease try again later.', name: 'someThingWentWrong');
  String get normal => Intl.message('Normal', name: 'normal');
  // String get faulty => Intl.message('Faulty', name: 'faulty');
  String get fireDrill => Intl.message('Fire Drill', name: 'fireDrill');
  String get evacuateConfirmationMessage => Intl.message('Are you sure to proceed with the Building Evacuation?', name: 'evacuateConfirmationMessage');
  String get fireDrillConfirmationMessage => Intl.message('Are you sure to proceed with the Building Fire Drill?', name: 'fireDrillConfirmationMessage');
  String get yes => Intl.message('Yes', name: 'yes');
  String get no => Intl.message('No', name: 'no');
  String get muteEmailNotification => Intl.message('Mute Email Notifications', name: 'muteEmailNotification');
  String get contactUs => Intl.message('Contact Us', name: 'contactUs');
  String get fullName => Intl.message('Full Name', name: 'fullName');
  String get subject => Intl.message('Subject', name: 'subject');
  String get body => Intl.message('Body', name: 'body');
  String get searchCountry => Intl.message('', name: 'searchCountry');
  String get enterValidPhoneNumber => Intl.message('', name: 'enterValidPhoneNumber');
  String get contactUsToCreateNewAccount => Intl.message('Contact Us To Create New Account', name: 'contactUsToCreateNewAccount');
  String get haveNoAccount => Intl.message('Have no account! ', name: 'haveNoAccount');
  String get to => Intl.message('To ', name: 'to');
  String get createAccount => Intl.message('Create Account ', name: 'createAccount');







}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
