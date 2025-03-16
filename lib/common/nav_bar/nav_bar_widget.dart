import 'package:etammn/common/blocs/theme/theme_manager_bloc.dart';
import 'package:etammn/common/widgets/app_image.dart';
import 'package:flutter/material.dart';
import '../../utilities/constants/app_text_style.dart';
import '../../utilities/constants/assets.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/localization/localizations.dart';
import '../../utilities/size_config.dart';
import '../widgets/app_text.dart';
import 'nav_bar_bloc.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemesTypes>(
        stream: themeManagerBloc.themeDataSubject,
        builder: (context, snapshot) {
          return Container(
            height: SizeConfig.appBarHeight +
                MediaQuery.of(context).viewPadding.bottom,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            decoration: BoxDecoration(
                color: AppColors.profileItemBGColor(),
                border: const Border(
                    top: BorderSide(color: AppColors.borderColor, width: .7))),
            child: StreamBuilder<int>(
                stream: bottomNavBarBloc.indexStream,
                builder: (context, snapshot) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: navBarItem(
                              index: bottomNavBarBloc.dashboard,
                              iconPath: AppAssets.dashboard,
                              title: AppLocalizations.of(context).dashboard,
                              color: snapshot.data == bottomNavBarBloc.dashboard
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor)),
                      Expanded(
                          child: navBarItem(
                              index: bottomNavBarBloc.users,
                              iconPath: AppAssets.users,
                              title: AppLocalizations.of(context).users,
                              color: snapshot.data == bottomNavBarBloc.users
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor)),
                      Expanded(
                          child: navBarItem(
                              index: bottomNavBarBloc.notifications,
                              iconPath: AppAssets.notifications,
                              title: AppLocalizations.of(context).notifications,
                              color: snapshot.data ==
                                      bottomNavBarBloc.notifications
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor)),
                      Expanded(
                          child: navBarItem(
                              index: bottomNavBarBloc.menu,
                              iconPath: AppAssets.menu,
                              title: AppLocalizations.of(context).menu,
                              color: snapshot.data == bottomNavBarBloc.menu
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor)),
                    ],
                  );
                }),
          );
        });
  }

  Widget navBarItem(
      {required int index,
      required String iconPath,
      String? title,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          bottomNavBarBloc.pickItem(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppImage(
              path: iconPath,
              height: SizeConfig.iconSize,
              width: SizeConfig.iconSize,
              color: color,
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: AppText(
                label: title ?? '',
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.tapBarTextFontSize,
                    fontColor: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
