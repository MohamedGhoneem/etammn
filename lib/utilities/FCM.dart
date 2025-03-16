///================================================
///================================================
import 'dart:convert';
import 'dart:developer';
import 'package:etammn/common/blocs/change_system_mode/bloc/change_system_mode_bloc.dart';
import 'package:etammn/common/widgets/app_dialog.dart';
import 'package:etammn/common/widgets/app_dialog_content.dart';
import 'package:etammn/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/shared_preferences_helper.dart';
import 'package:etammn/utilities/shared_preferences_keys.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'constants/assets.dart';
import 'constants/constants.dart';
import 'notification_sound_manager.dart';

enum NotificationSoundENum { fire, warning, duration }

// class FCM {
//   FCM._();

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void fcmConfigure() {
  // final soundManager = NotificationSoundManager();
  // await soundManager.initialize();
  initLocalNotification();
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    print('FirebaseMessaging.getInitialMessage');

    if (message != null) {
      onMessage(
        message,
      );
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // final soundType = message.notification?.android?.sound as String? ?? 'fire';
    // await soundManager.playSound(soundType);
    onMessage(
      message,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    onMessage(
      message,
    );
  });
}

///===================================================================================
Future initLocalNotification() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings("@drawable/logo");
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          // onDidReceiveLocalNotification: onDidReceiveLocalNotification
          );
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // onSelectNotification: selectNotification
  );
}

void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  showDialog(
    context: AppConstants.navigatorKey.currentState!.context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(body ?? ''),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () async {},
        )
      ],
    ),
  );
}

void requestPermissions() async {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<void> showNotification(RemoteMessage message) async {
  if (message.notification?.android?.sound?.toLowerCase() ==
      NotificationSoundENum.duration.name) {
    ChangeSystemModeBloc changeSystemModeBloc = ChangeSystemModeBloc();
    String systemId = message.data['system_id'];
    String endTime = message.data['manual_mode_untill'];
    String? msgess = message.notification?.body;

    AppDialog appDialog = AppDialog();
    appDialog.child = AppDialogContent(
      description: """$msgess \n
            ${AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).extendMessage}""",
      okButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .extend,
      okBtnTapped: () {
        Utilities.popWidget();
        changeSystemModeBloc.extended = true;
        changeSystemModeBloc.checkBokhorMode(
            changeSystemModeBloc.bakhourMode, int.parse(systemId));
      },
      cancelButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .ok,
      cancelBtnTapped: () {
        Utilities.popWidget();
      },
    );
    Utilities.showAppDialog(appDialog);
  } else {
    // String androidSound =
    //     message.notification?.android?.sound?.toLowerCase() == 'fire'
    //         ? 'fire_alert'
    //         : 'warning';
    // String iosSound =
    //     message.notification?.android?.sound?.toLowerCase() == 'fire'
    //         ? 'fire_alert.wave'
    //         : 'warning.wave';

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'etammn_notification_channel_id', 'yourchannelname',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('fire'),
        ticker: 'ticker');
    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'fire.wav');

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
        payload: jsonEncode(message.data));
  }
}

Future<void> onMessage(
  RemoteMessage message,
) async {
  log("--- onMessage: ${message.toMap()}");
  log("--- onMessage:onMessage:onMessage:onMessage:onMessage:onMessage:");
  // dashboardBloc.isFirstPlay=true;

  // if (message.notification?.android?.sound?.toLowerCase() ==
  //     NotificationSoundENum.fire.name) {
  //   Utilities.playSound(AppAssets.fireAlert);
  // } else {
  //   Utilities.playSound(AppAssets.warningAlert);
  // }

  bool pauseNotification = SharedPreferenceHelper.getValueForKey(
          SharedPrefsKeys.pauseNotification) ??
      false;
  debugPrint('pauseNotification : $pauseNotification');

  if (pauseNotification) {
    dashboardBloc.getDashboard(fromNotification: true);
    systemDetailsBloc.getSystemDetails();
  } else {
    showNotification(message);
    dashboardBloc.getDashboard(fromNotification: true);
    systemDetailsBloc.getSystemDetails();
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  showNotification(message);
  log("Handling a background message: ${message.messageId}");
}

///================================================
