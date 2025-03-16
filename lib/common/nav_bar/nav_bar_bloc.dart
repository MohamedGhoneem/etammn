import 'dart:async';
import 'package:etammn/common/blocs/firebase_token/firebase_token_bloc.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/dashboard/view/dashboard_view.dart';
import 'package:etammn/features/menu/view/menu_view.dart';
import 'package:etammn/features/notifications/bloc/notifications_bloc.dart';
import 'package:etammn/features/notifications/view/notifications_view.dart';
import 'package:etammn/features/users/view/users_view.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/change_language/bloc/change_language_bloc.dart';

class NavBarBloc {
  final BehaviorSubject<int> _currentIndex = BehaviorSubject<int>.seeded(0);

  Stream<int> get indexStream => _currentIndex.stream;

  final BehaviorSubject<String> _currentTitle = BehaviorSubject<String>.seeded(
      AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
          .dashboard);

  Stream<String> get titleStream => _currentTitle.stream;

  BehaviorSubject<Widget> selectedWidget = BehaviorSubject.seeded( const DashboardView());

  bool homeListViewIsViewed = true;
  int dashboard = 0;
  int users = 1;
  int notifications = 2;
  int menu = 3;

  void pickItem(int i) async {
    int previousIndex = _currentIndex.value;
    _currentIndex.sink.add(i);
    switch (i) {
      case 0:
        _currentTitle.sink.add(
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .dashboard);
        selectedWidget.sink.add(const DashboardView());

        break;
      case 1:
        _currentTitle.sink.add(
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .users);
        selectedWidget.sink.add(const UsersView(
          showBackButton: false,
        ));
        break;
      case 2:
        _currentTitle.sink.add(
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .notifications);
        selectedWidget.sink.add(BlocProvider(
            bloc: NotificationsBloc(), child: const NotificationsView()));
        break;
      case 3:
        _currentTitle.sink.add(
            AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
                .menu);
        selectedWidget.sink.add(
            BlocProvider(bloc: ChangeLanguageBloc(), child:  BlocProvider<FirebaseTokenBloc>(
              bloc: FirebaseTokenBloc(),
              child: const MenuView()),
            ));
        break;
      case 4:
        pickItem(previousIndex);
        break;
    }
  }

  dispose() {
    _currentIndex.close();
    _currentTitle.close();
  }
}

final bottomNavBarBloc = NavBarBloc();
