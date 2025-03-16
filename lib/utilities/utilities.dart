import 'dart:io';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_share/flutter_share.dart';
// import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/widgets/app_dialog.dart';
import '../common/widgets/app_loading_dialog.dart';
import 'constants/colors.dart';
import 'constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'localization/locale_helper.dart';
import 'shared_preferences_helper.dart';
import 'shared_preferences_keys.dart';
import 'size_config.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

enum SocialType { FACEBOOK, WHATSAPP, INSTAGRAM, TWITTER, EMAIL, PHONE }

class Utilities {
  static setLanguage(String language) {
    helper.onLocaleChanged!(Locale(language));
    SharedPreferenceHelper.setValueForKey(
        SharedPrefsKeys.languageKey, language);
  }

  static String getLanguage() {
    return SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.languageKey) ??
        'en';
  }

  static String formatSessionDate(String currentDate) {
    // String dateFormat = intl.DateFormat("HH:mm:ss a  |  yyyy-MM-dd 'Z").format(DateTime.parse(currentDate));
    String dateFormat =
        intl.DateFormat.yMMMMd().format(DateTime.parse(currentDate).toLocal());
    String timeFormat =
        intl.DateFormat.jms().format(DateTime.parse(currentDate).toLocal());
    return '$timeFormat | $dateFormat';
  }

  static String fromDateWithoutTimeToString(DateTime dateTime) {
    intl.DateFormat dateFormat = intl.DateFormat("yyyy-MM-dd", "EN");
    return dateFormat.format(dateTime);
  }

  static String formattedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString());

    return parsedTime;
  }

  static void showToast(
      {Widget? icon,
      required String msg,
      required Color backgroundColor,
      required Color fontColor,
      required BuildContext context,
      ToastGravity? gravity}) {
    // Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: backgroundColor,
    //     textColor: fontColor,
    //     fontSize: SizeConfig.titleFontSize);

    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      toastDuration: const Duration(milliseconds: 4000),
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.padding * 5)),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              Expanded(
                child: Text(
                  msg,
                  style: TextStyle(color: fontColor, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
      gravity: gravity ?? ToastGravity.CENTER,
    );
  }

  static List<String> splitPhrase(String phrase) {
    List<String> arr = phrase.split(' ');
    arr.removeWhere((item) => item.trim().isEmpty);
    return arr;
  }

  static popWidget() {
    Navigator.pop(AppConstants.navigatorKey.currentState!.context);
  }

  static navigateAndPop(Widget widget) {
    AppConstants.navigatorKey.currentState?.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => widget,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  static navigate(Widget widget) {
    AppConstants.navigatorKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => widget,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  static Future<DateTime?> getDatePicker({DateTime? initialDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text(""),
        );
      },
      context: AppConstants.navigatorKey.currentState!.context,
      initialDate: initialDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1950, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      return pickedDate;
    } else {
      return initialDate ?? DateTime.now();
    }
  }

  static Future<DateTime?> getTimePicker(DateTime pickedDate) async {
    DateTime? newDate;
    Future<TimeOfDay?> selectedTimeRTL = showTimePicker(
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text(""),
        );
      },
      context: AppConstants.navigatorKey.currentState!.context,
      initialTime: TimeOfDay.now(),
    );
    selectedTimeRTL.then((value) {
      newDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          value!.hour,
          value.minute,
          pickedDate.second,
          pickedDate.millisecond,
          pickedDate.microsecond);
    });
    return newDate;
  }

  static void showLoadingDialog() async {
    await showDialog(
        context: AppConstants.navigatorKey.currentState!.context,
        barrierDismissible: false,
        barrierColor: AppColors.transparentColor,
        builder: (BuildContext context) => appLoadingDialog);
  }

  static Future<void>? hideLoadingDialog() {
    if (appLoadingDialog.isShowing()) {
      appLoadingDialog.pop();
      appLoadingDialog = AppLoadingDialog();
    }
    return null;
  }

  static Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  static void showAppDialog(AppDialog appDialog) async {
    await showDialog(
        context: AppConstants.navigatorKey.currentState!.context,
        barrierDismissible: false,
        builder: (BuildContext context) => appDialog);
  }

  static Future<void>? hideAppDialog(AppDialog appDialog) {
    if (appDialog.isShowing()) {
      appDialog.pop();
      appDialog = AppDialog();
    }
    return null;
  }

  static socialMediaBtnTapped(SocialType type, String url) {
    switch (type) {
      case SocialType.FACEBOOK:
        UrlLauncher.launch(url);
        break;
      case SocialType.WHATSAPP:
        UrlLauncher.launch('https://wa.me/$url');
        break;
      case SocialType.INSTAGRAM:
        UrlLauncher.launch(url);
        break;
      case SocialType.TWITTER:
        UrlLauncher.launch(url);
        break;
      case SocialType.EMAIL:
        UrlLauncher.launch('mailto:$url');
        break;
      case SocialType.PHONE:
        UrlLauncher.launch('tel://$url');
        break;
    }
  }

  static launchMaps(lat, long) async {
    // if(Platform.isIOS){
    // UrlLauncher.launchUrl(Uri.parse('https://maps.apple.com/?sll=9.535749,24.865840'));
    // UrlLauncher.launchUrl(Uri.parse('https://maps.apple.com/?sll==$lat,$long'));

    // }else{
    // UrlLauncher.launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=9.535749,24.865840'));
    UrlLauncher.launch(
        "https://www.google.com/maps/search/?api=1&query=$lat,$long");
    // }
  }

  // static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  static playSound(String path) {
    // Listen to the audio player's state
    // if (assetsAudioPlayer.isPlaying.value) return;
    // assetsAudioPlayer.open(
    //   Audio(path),
    //   autoStart: true,
    //   showNotification: false,
    //   volume: 100,
    //   loopMode: LoopMode.single,
    // );
    // Future.delayed(const Duration(seconds: 20), () {
    //   assetsAudioPlayer.stop();
    // });
  }

  static Future<void> checkNotificationPermission() async {
    final status = await Permission.notification.request();

    if (status.isDenied) {
      // Show a dialog asking the user if they want to open app settings
      final shouldOpenSettings = await showDialog<bool>(
        context: AppConstants.navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Denied'),
            content: const Text('Please enable notifications in settings.'),
            actions: [
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // User wants to open settings
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false); // User cancels
                },
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        // Open app settings
        await openAppSettings();
      }
    }
  }
}
