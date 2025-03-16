import 'dart:io';

import 'package:etammn/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/base_stateful_widget.dart';
import '../common/nav_bar/nav_bar_bloc.dart';
import '../common/widgets/app_dialog.dart';
import '../common/widgets/app_dialog_content.dart';
import '../utilities/localization/localizations.dart';
import '../utilities/utilities.dart';
import 'dashboard/view/dashboard_view.dart';

class MainView extends BaseStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  DateTime? currentBackPressTime;

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody

    return StreamBuilder<Widget>(
        stream: bottomNavBarBloc.selectedWidget.stream,
        builder: (context, snapshot) {
          return snapshot.data ?? const DashboardView();
        });
  }

  @override
  PreferredSizeWidget? setAppbar() {
    // TODO: implement setAppbar
    return null;
  }

  @override
  bool setResizeToAvoidBottomInset() {
    // TODO: implement setResizeToAvoidBottomInset
    return true;
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return true;
  }

  @override
  Future<bool> setOnWillPop() {
    // TODO: implement onWillPop
    // if (bottomNavBarBloc.selectedWidget.value != const HomeView()) {
    if (bottomNavBarBloc.selectedWidget.value is DashboardView) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Utilities.showToast(
          // icon: const Icon(Icons.cancel_outlined,size: 20,color: AppColors.redColor,),
            msg: AppLocalizations.of(context).clickTwice,
            backgroundColor: AppColors.lightGreyColor,
            fontColor: AppColors.redColor,
            context: context,
            gravity: ToastGravity.BOTTOM);
        return Future.value(false);
      }
      exit(0);
      // return Future.value(true);
    } else {
      bottomNavBarBloc.pickItem(bottomNavBarBloc.dashboard);
      return Future.value(false);
    }
  }
}
