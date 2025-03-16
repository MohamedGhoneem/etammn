import 'package:etammn/common/blocs/log_out/log_out_bloc.dart';
import 'package:etammn/common/blocs/theme/theme_manager_bloc.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/common/widgets/app_web_view.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/core/network/api_constants.dart';
import 'package:etammn/features/change_language/bloc/change_language_bloc.dart';
import 'package:etammn/features/change_language/view/change_language_view.dart';
import 'package:etammn/features/menu/bloc/menu_bloc.dart';
import 'package:etammn/features/profile/view/profile_view.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_image.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/size_config.dart';
import '../../contact_us/bloc/contact_us_bloc.dart';
import '../../contact_us/view/contact_us_view.dart';
import 'widget/button_item_widget.dart';
import 'widget/toggle_item_widget.dart';

class MenuView extends BaseStatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends BaseState<MenuView> {
  late MenuBloc _menuBloc;
  late FirebaseTokenBloc _firebaseTokenBloc;

  final LogOutBloc _logOutBloc = LogOutBloc();

  late ChangeLanguageBloc _changeLanguageBloc;

  @override
  void initState() {
    super.initState();
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _changeLanguageBloc = BlocProvider.of<ChangeLanguageBloc>(context);
    _firebaseTokenBloc = BlocProvider.of<FirebaseTokenBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonItemWidget(
            title: AppLocalizations.of(context).myProfile,
            iconPath: AppAssets.profile,
            changeLanguageBloc: _changeLanguageBloc,
            onTap: () => Utilities.navigate(const ProfileView()),
          ),
          ToggleItemWidget(
            title: AppLocalizations.of(context).pauseNotification,
            iconPath: AppAssets.notifications,
            subject: _menuBloc.pauseNotificationSubject,
            onTap: _menuBloc.pauseNotification,
          ),
          ToggleItemWidget(
            title: AppLocalizations.of(context).muteEmailNotification,
            iconPath: AppAssets.notifications,
            subject: _menuBloc.muteEmailNotificationSubject,
            onTap: _menuBloc.muteEmailNotification,
          ),
          StreamBuilder<ThemesTypes>(
              stream: themeManagerBloc.themeDataSubject.stream,
              builder: (context, snapshot) {
                return ToggleItemWidget(
                  title: AppLocalizations.of(context).darkMode,
                  iconPath: AppAssets.darkMode,
                  subject: _menuBloc.darkModeSubject,
                  onTap: _menuBloc.changeTheme,
                );
              }),
          ButtonItemWidget(
            title: AppLocalizations.of(context).language,
            iconPath: AppAssets.language,
            onTap: () => Utilities.navigate(ChangeLanguageView(
              changeLanguageBloc: _changeLanguageBloc,
            )),
            changeLanguageBloc: _changeLanguageBloc,
          ),
          ButtonItemWidget(
            title: AppLocalizations.of(context).helpCenter,
            iconPath: AppAssets.help,
            changeLanguageBloc: _changeLanguageBloc,
            onTap: () => Utilities.navigate(AppWebView(
                title: AppLocalizations.of(context).helpCenter,
                url: '${ApiConstants.baseUrl}v1/faqs')),
          ),
          ButtonItemWidget(
            title: AppLocalizations.of(context).privacyPolicy,
            iconPath: AppAssets.privacyPolicy,
            changeLanguageBloc: _changeLanguageBloc,
            onTap: () => Utilities.navigate(AppWebView(
                title: AppLocalizations.of(context).privacyPolicy,
                url: '${ApiConstants.baseUrl}v1/policy')),
          ),
          ButtonItemWidget(
            title: AppLocalizations.of(context).termsOfUse,
            iconPath: AppAssets.terms,
            changeLanguageBloc: _changeLanguageBloc,
            onTap: () => Utilities.navigate(AppWebView(
                title: AppLocalizations.of(context).termsOfUse,
                url: '${ApiConstants.baseUrl}v1/terms')),
          ),
          ButtonItemWidget(
            title: AppLocalizations.of(context).contactUs,
            iconPath: AppAssets.terms,
            changeLanguageBloc: _changeLanguageBloc,
            onTap: ()=>Utilities.navigate(BlocProvider(bloc: ContactUsBloc(),
              child: const ContactUsView(
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding),
            child: AppButton(
                title: AppLocalizations.of(context).logout,
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.textFontSize,
                    fontColor: AppColors.whiteColor),
                borderColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor,
                width: SizeConfig.blockSizeHorizontal * 100,
                radius: SizeConfig.blockSizeHorizontal * 2,
                alignment: AppButtonAlign.centerStartIcon,
                icon: AppImage(
                  path: AppAssets.logout,
                  width: SizeConfig.iconSize,
                  height: SizeConfig.iconSize,
                  color: AppColors.whiteColor,
                ),
                onTap: () => _logOutBloc.logOut(_changeLanguageBloc, _firebaseTokenBloc)),
          )
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    // TODO: implement setAppbar
    return PreferredSize(
      preferredSize:
          Size(SizeConfig.blockSizeHorizontal * 100, SizeConfig.appBarHeight),
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top > 0
                  ? MediaQuery.of(context).viewPadding.top
                  : SizeConfig.padding,
              bottom: SizeConfig.padding),
          decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
            child: AppText(
              label: AppLocalizations.of(context).menu,
              textAlign: TextAlign.start,
              style: AppTextStyle.style(
                  fontFamily: '',
                  fontSize: SizeConfig.titleFontSize,
                  fontColor: AppColors.fontColor()),
            ),
          )),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement setScaffoldBackgroundColor
    return AppColors.backGroundColor();
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }
}
