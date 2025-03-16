import 'dart:convert';
import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_container_with_label.dart';
import 'package:etammn/common/widgets/app_image.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../common/models/user_model.dart';
import '../../../../common/widgets/app_back_icon.dart';
import '../../../../utilities/shared_preferences_helper.dart';
import '../../../../utilities/shared_preferences_keys.dart';
import '../../../../common/models/system_item_model.dart';
import '../../../sign_in/model/sign_in_response_model.dart';
import '../../edit_user/bloc/edit_user_bloc.dart';
import '../../edit_user/view/edit_user_view.dart';
import '../bloc/user_details_bloc.dart';
import 'widget/user_systems_item.dart';
import 'widget/users_control_widget.dart';

class UserDetailsView extends BaseStatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends BaseState<UserDetailsView> {
  late UserDetailsBloc _userDetailsBloc;
  late SignInResponseModel _userModel;

  @override
  void initState() {
    super.initState();
    _userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    _userModel = SignInResponseModel.fromJson(json.decode(
        SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: StreamBuilder<UserModel?>(
          stream: _userDetailsBloc.userModelSubject.stream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.all(SizeConfig.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.padding * 2),
                  AppImage(
                    path: snapshot.data?.avatar ?? '',
                    width: SizeConfig.blockSizeHorizontal * 30,
                    height: SizeConfig.blockSizeHorizontal * 30,
                    boxFit: BoxFit.fill,
                    isCircular: true,
                  ),
                  SizedBox(height: SizeConfig.padding * 1.5),
                  AppText(
                    label: snapshot.data?.username ?? '',
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor(),
                    ),
                  ),
                  SizedBox(height: SizeConfig.padding * 2),
                  AppButton(
                    title:
                        '${snapshot.data?.countryKey ?? ' '} - ${snapshot.data?.mobile ?? ' '}',
                    borderColor: AppColors.primaryColor.withOpacity(.03),
                    backgroundColor: AppColors.primaryColor.withOpacity(.03),
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                    alignment: AppButtonAlign.start,
                    style: AppTextStyle.style(
                        fontFamily: '',
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.fontColor()),
                    icon: SvgPicture.asset(
                      AppAssets.mobile,
                      height: SizeConfig.iconSize,
                      width: SizeConfig.iconSize,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () => Utilities.socialMediaBtnTapped(
                        SocialType.PHONE,
                        '${snapshot.data?.countryKey ?? ''}${snapshot.data?.mobile ?? ' '}'),
                  ),
                  SizedBox(height: SizeConfig.padding),
                  if (snapshot.data?.email != null)
                    AppButton(
                      title: snapshot.data?.email ?? '',
                      borderColor: AppColors.primaryColor.withOpacity(.03),
                      backgroundColor: AppColors.primaryColor.withOpacity(.03),
                      radius: SizeConfig.blockSizeHorizontal * 2,
                      padding:
                          EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                      alignment: AppButtonAlign.start,
                      style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.fontColor()),
                      icon: AppImage(
                        path: AppAssets.email,
                        height: SizeConfig.iconSize,
                        width: SizeConfig.iconSize,
                        color: AppColors.primaryColor,
                      ),
                      onTap: () => Utilities.socialMediaBtnTapped(
                          SocialType.EMAIL, snapshot.data?.email ?? ''),
                    ),
                  SizedBox(height: SizeConfig.padding * 3),
                  AppContainerWithLabel(
                    borderColor: AppColors.lightGreyColor,
                    label: AppText(
                        label: AppLocalizations.of(context).usersControl),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.padding),
                      child: UsersControlWidget(
                        clickable: false,
                        bloc: _userDetailsBloc,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.padding * 2),
                  AppContainerWithLabel(
                    borderColor: AppColors.lightGreyColor,
                    label: AppText(
                        label: AppLocalizations.of(context).allowedSystems),
                    child: StreamBuilder<List<SystemItemModel>?>(
                        stream: _userDetailsBloc.userSystemSubject,
                        builder: (context, systemsSnapshot) {
                          return systemsSnapshot.hasData &&
                                  systemsSnapshot.data != []
                              ? ListView.builder(
                                  itemCount: systemsSnapshot.data?.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return UserSystemsItem(
                                      content: systemsSnapshot.data?[index],
                                      bloc: _userDetailsBloc,
                                    );
                                  })
                              : const SizedBox();
                        }),
                  ),
                  SizedBox(height: SizeConfig.padding * 3),
                  if (_userModel.user?.usersControl == 1)
                    Center(
                      child: AppButton(
                          title: AppLocalizations.of(context).deleteUser,
                          style: AppTextStyle.style(
                              fontFamily: Fonts.regular.name,
                              fontSize: SizeConfig.textFontSize,
                              fontColor: AppColors.whiteColor),
                          borderColor: AppColors.primaryColor,
                          backgroundColor: AppColors.primaryColor,
                          width: SizeConfig.blockSizeHorizontal * 60,
                          radius: SizeConfig.blockSizeHorizontal * 2,
                          alignment: AppButtonAlign.center,
                          onTap: () => _userDetailsBloc.deleteUser()),
                    ),
                ],
              ),
            );
          }),
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
              top: MediaQuery.of(context).viewPadding.top,
              bottom: SizeConfig.padding),
          decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
          ),
          child: Row(
            children: [
              AppBackIcon(
                onTap: setOnWillPop,
              ),
              const Spacer(),
              if (_userModel.user?.usersControl == 1)
                AppButton(
                  title: '',
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  icon: SvgPicture.asset(AppAssets.edit,
                      color: AppColors.primaryColor,
                      width: SizeConfig.smallIconSize,
                      height: SizeConfig.smallIconSize),
                  onTap: () => Utilities.navigate(
                    BlocProvider(
                      bloc: EditUserBloc(
                          content: _userDetailsBloc.userModelSubject.value,
                          userDetailsBloc: _userDetailsBloc),
                      child: const EditUserView(),
                    ),
                  ),
                ),
            ],
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
