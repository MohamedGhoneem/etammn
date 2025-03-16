import 'dart:developer';
import 'dart:io';
import 'package:etammn/firebase_options.dart';
import 'package:etammn/utilities/FCM.dart';
import 'package:etammn/utilities/constants/assets.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'common/blocs/theme/theme_manager_bloc.dart';
import 'core/bloc_provider.dart';
import 'core/main_app.dart';

Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // if (Platform.isIOS) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyA9uCX-pUsOetcqTXi6g22Vb6Lw3Pv06qk",
  //       //your api key Found in GoogleService-info.plist
  //       appId: "1:888295861595:ios:ef5e7eebe8625985877e7e",
  //       //Your app id found in Firebase
  //       messagingSenderId: "888295861595",
  //       //Your Sender id found in Firebase
  //       projectId: "etammn-16564", //Your Project id found in Firebase
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FCM.configure();
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  /// Firebase===============
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  fcmConfigure();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    BlocProvider(
      bloc: ThemeManagerBloc(),
      child: const MainApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
