import 'package:country_code_picker/country_code_picker.dart';
import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../common/widgets/app_text_form_field_item.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../common/widgets/app_image.dart';
import '../bloc/change_password_bloc.dart';

class ChangePasswordView extends BaseStatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends BaseState<ChangePasswordView> {
  late ChangePasswordBloc _changePasswordBloc;

  @override
  void initState() {
    super.initState();
    _changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.padding),
        child: Form(
          key: _changePasswordBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.padding * 2),
              Center(
                child: AppImage(
                  path: AppAssets.coloredLogoPng,
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeHorizontal * 20,
                ),
              ),
              SizedBox(height: SizeConfig.padding * 2),
              if (_changePasswordBloc.isUpdateProfile == true)
                AppTextFormFieldItem(
                    title: AppLocalizations.of(context).currentPassword,
                    obscureTextSubject: _changePasswordBloc.obscureTextSubject,
                    formFieldItemType: AppFormFieldItemType.password,
                    subject: _changePasswordBloc.currentPasswordSubject,
                    textInputType: TextInputType.text,
                    fontColor: AppColors.fontColor(),
                    labelFontColor: AppColors.greyColor,
                    borderColor: AppColors.greyColor,
                    focusedBorderColor: AppColors.primaryColor,
                    iconColor: AppColors.greyColor,
                    focusedIconColor: AppColors.primaryColor,
                    showHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.padding * 1.5),
                      child: SvgPicture.asset(
                        AppAssets.password,
                        height: SizeConfig.iconSize,
                        width: SizeConfig.iconSize,
                      ),
                    ),
                    validator: (value) =>
                        _changePasswordBloc.validateCurrentPassword(value!)),
              if (_changePasswordBloc.isUpdateProfile == true)
                SizedBox(height: SizeConfig.padding),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).password,
                  obscureTextSubject: _changePasswordBloc.obscureTextSubject,
                  formFieldItemType: AppFormFieldItemType.password,
                  subject: _changePasswordBloc.passwordSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.padding * 1.5),
                    child: SvgPicture.asset(
                      AppAssets.password,
                      height: SizeConfig.iconSize,
                      width: SizeConfig.iconSize,
                    ),
                  ),
                  validator: (value) =>
                      _changePasswordBloc.validatePassword(value!)),
              SizedBox(height: SizeConfig.padding),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).confirmPassword,
                  obscureTextSubject: _changePasswordBloc.obscureTextSubject,
                  formFieldItemType: AppFormFieldItemType.password,
                  subject: _changePasswordBloc.confirmPasswordSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.padding * 1.5),
                    child: SvgPicture.asset(
                      AppAssets.password,
                      height: SizeConfig.iconSize,
                      width: SizeConfig.iconSize,
                    ),
                  ),
                  validator: (value) =>
                      _changePasswordBloc.validateConfirmNewPassword(value!)),
              SizedBox(height: SizeConfig.padding * 3),
              Center(
                child: AppButton(
                    title: AppLocalizations.of(context).confirm,
                    style: AppTextStyle.style(
                        fontFamily: Fonts.regular.name,
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.whiteColor),
                    borderColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor,
                    width: SizeConfig.blockSizeHorizontal * 60,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    alignment: AppButtonAlign.center,
                    onTap: () =>
                        _changePasswordBloc.formKey.currentState!.validate()
                            ? _changePasswordBloc.changePassword()
                            : null),
              ),
            ],
          ),
        ),
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
              AppButton(
                  title: '',
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  icon: SvgPicture.asset(AppAssets.back,
                      width: SizeConfig.iconSize, height: SizeConfig.iconSize),
                  onTap: () => super.setOnWillPop()),
              Expanded(
                  child: AppText(
                label: AppLocalizations.of(context).changePassword,
                style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.fontColor()),
                textAlign: TextAlign.center,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                child: SizedBox(
                  width: SizeConfig.iconSize,
                ),
              )
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
