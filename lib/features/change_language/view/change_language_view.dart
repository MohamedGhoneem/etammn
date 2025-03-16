import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/app_back_icon.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_image.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import '../bloc/change_language_bloc.dart';

class ChangeLanguageView extends BaseStatefulWidget {
  final ChangeLanguageBloc changeLanguageBloc;

  const ChangeLanguageView({Key? key, required this.changeLanguageBloc})
      : super(key: key);

  @override
  _ChangeLanguageViewState createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends BaseState<ChangeLanguageView> {
  @override
  Widget setBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
      child: StreamBuilder<bool>(
          stream: widget.changeLanguageBloc.isArabicLanguageSubject,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 8),
                Center(
                    child: AppImage(
                  path: AppAssets.coloredLogoPng,
                  width: SizeConfig.blockSizeHorizontal * 40,
                  // height: SizeConfig.blockSizeHorizontal * 20,
                )),
                SizedBox(height: SizeConfig.blockSizeVertical * 5),
                AppButton(
                    title: AppLocalizations.of(context).arabicLanguage,
                    style: AppTextStyle.style(
                        fontFamily: '',
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.fontColor()),
                    borderColor: AppColors.greyColor,
                    backgroundColor: AppColors.profileItemBGColor(),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                    icon: snapshot.hasData && snapshot.data!
                        ? const Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                          )
                        : const SizedBox(),
                    alignment: AppButtonAlign.expandedEndIcon,
                    onTap: widget.changeLanguageBloc.setArabicLanguage),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                AppButton(
                    title: AppLocalizations.of(context).englishLanguage,
                    style: AppTextStyle.style(
                        fontFamily: '',
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.fontColor()),
                    borderColor: AppColors.greyColor,
                    backgroundColor: AppColors.profileItemBGColor(),
                    width: SizeConfig.blockSizeHorizontal * 100,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                    icon: snapshot.hasData && !snapshot.data!
                        ? const Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                          )
                        : const SizedBox(),
                    alignment: AppButtonAlign.expandedEndIcon,
                    onTap: widget.changeLanguageBloc.setEnglishLanguage),
              ],
            );
          }),
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    // TODO: implement setAppbar
    return PreferredSize(
        preferredSize: Size(SizeConfig.blockSizeHorizontal * 100,
        SizeConfig.appBarHeight),
    child: Container(
    width: SizeConfig.blockSizeHorizontal * 100,
    padding: EdgeInsets.only(
    top: MediaQuery.of(context).viewPadding.top,
    bottom: SizeConfig.padding),
    decoration:const BoxDecoration(
    color: AppColors.transparentColor,
    ),
      child: Row(
        children: [AppBackIcon(onTap: () => super.setOnWillPop())],
      ),
    ),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement getScaffoldBackgroundColor
    return AppColors.backGroundColor();
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }
}
