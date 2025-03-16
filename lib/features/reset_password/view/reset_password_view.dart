import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/blocs/countries/countries_bloc.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_image.dart';
import '../../../common/widgets/app_text_form_field_item.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import '../../../utilities/utilities.dart';
import '../../change_language/bloc/change_language_bloc.dart';
import '../../sign_in/bloc/sign_in_bloc.dart';
import '../../sign_in/view/sign_in_view.dart';
import '../bloc/reset_password_bloc.dart';

class ResetPasswordView extends BaseStatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends BaseState<ResetPasswordView> {
  ResetPasswordBloc? _resetPasswordBloc;

  @override
  void initState() {
    super.initState();
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.padding * 2,
            horizontal: SizeConfig.padding * 4),
        child: Form(
          key: _resetPasswordBloc?.formKey,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.padding * 5),
              Center(
                child: AppImage(
                  path: AppAssets.coloredLogoPng,
                  width: SizeConfig.blockSizeHorizontal * 50,
                  height: SizeConfig.blockSizeHorizontal * 50,
                ),
              ),
              SizedBox(height: SizeConfig.padding * 5),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).newPassword,
                  formFieldItemType: AppFormFieldItemType.password,
                  subject: _resetPasswordBloc!.newPasswordSubject,
                  obscureTextSubject: _resetPasswordBloc?.obscureTextSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.primaryColor,
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.padding * 1.5),
                    child: SvgPicture.asset(AppAssets.password,height: SizeConfig.iconSize,width: SizeConfig.iconSize,),
                  ),
                  validator: (value) =>
                      _resetPasswordBloc?.validatePassword(value!)),
              SizedBox(height: SizeConfig.padding * 2),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).confirmNewPassword,
                  formFieldItemType: AppFormFieldItemType.password,
                  subject: _resetPasswordBloc!.confirmNewPasswordSubject,
                  obscureTextSubject: _resetPasswordBloc?.obscureTextSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.primaryColor,
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.padding * 1.5),
                    child: SvgPicture.asset(AppAssets.password,height: SizeConfig.iconSize,width: SizeConfig.iconSize,),
                  ),
                  validator: (value) =>
                      _resetPasswordBloc?.validateConfirmNewPassword(value!)),
              SizedBox(height: SizeConfig.padding * 3),
              AppButton(
                  title: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).confirm,
                  style: AppTextStyle.style(
                      fontFamily: Fonts.regular.name,
                      fontSize: SizeConfig.bigTitleFontSize,
                      fontColor: AppColors.whiteColor),
                  borderColor: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  radius: SizeConfig.blockSizeHorizontal * 2,
                  alignment: AppButtonAlign.center,
                  onTap: () =>
                      _resetPasswordBloc!.formKey.currentState!.validate()
                          ? _resetPasswordBloc?.resetPassword()
                          : null),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Future<bool> setOnWillPop() {
    // TODO: implement onWillPop
    return Utilities.navigateAndPop(
      BlocProvider(
        bloc: ChangeLanguageBloc(),
      child: BlocProvider<FirebaseTokenBloc>(
        bloc: FirebaseTokenBloc(),
        child: BlocProvider(
              bloc: SignInBloc(),
              child: const SignInView(),

          ),
      ),
    ),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement setScaffoldBackgroundColor
    return AppColors.whiteColor;
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }
}
