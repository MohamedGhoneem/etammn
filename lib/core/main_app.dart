import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:etammn/common/blocs/change_system_mode/bloc/change_system_mode_bloc.dart';
import 'package:etammn/common/blocs/countries/countries_bloc.dart';
import 'package:etammn/common/blocs/firebase_token/firebase_token_bloc.dart';
import 'package:etammn/common/blocs/log_out/log_out_bloc.dart';
import 'package:etammn/common/blocs/timer/timer_bloc.dart';
import 'package:etammn/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../features/splash/bloc/splash_bloc.dart';
import '../features/splash/view/splash_view.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/constants.dart';
import '../common/blocs/theme/theme_manager_bloc.dart';
import '../utilities/localization/locale_helper.dart';
import '../utilities/localization/localizations.dart';
import '../utilities/utilities.dart';
import 'bloc_provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  SpecificLocalizationDelegate? _specificLocalizationDelegate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(Locale(Utilities.getLanguage()));
    helper.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    if (mounted) {
      setState(() {
        _specificLocalizationDelegate = SpecificLocalizationDelegate(locale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return   BlocProvider<DashboardBloc>(
      bloc: DashboardBloc(),
      child: StreamBuilder<ThemesTypes>(
          stream: themeManagerBloc.themeDataSubject.stream,
          builder: (context, snapshot) {
            debugPrint('themeDataSubject : ${snapshot.data.toString()}');
          // if(snapshot.hasData) {
          //   bool idDark = snapshot.data?.name=='dark'?true:false;
          //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          //       systemNavigationBarColor: AppColors.fontColor(),
          //       systemNavigationBarDividerColor:AppColors.fontColor(),
          //       statusBarColor:AppColors.fontColor(),
          //   ));
          // }
            return MaterialApp(
              navigatorKey: AppConstants.navigatorKey,
              title: 'Etammn',
              color: AppColors.primaryColor,
              // theme: snapshot.data,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                _specificLocalizationDelegate!
              ],
              builder: BotToastInit(),
              supportedLocales: const [Locale('en'), Locale('ar')],
              locale: _specificLocalizationDelegate?.overriddenLocale,
              home: BlocProvider<FirebaseTokenBloc>(
                  bloc: FirebaseTokenBloc(),
                child: BlocProvider<SplashBloc>(
                    bloc: SplashBloc(), child: const SplashView()),
              ),
            );
          }),
    );
  }
}
