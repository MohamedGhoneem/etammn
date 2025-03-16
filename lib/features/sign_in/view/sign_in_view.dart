import 'package:country_code_picker/country_code_picker.dart';
import 'package:etammn/common/widgets/app_container_with_label.dart';
import 'package:etammn/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:etammn/features/forgot_password/view/forgot_password_view.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/blocs/countries/countries_bloc.dart';
import '../../../common/blocs/countries/countries_response_model.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/models/country_model.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_dropdown.dart';
import '../../../common/widgets/app_image.dart';
import '../../../common/widgets/app_text.dart';
import '../../../common/widgets/app_text_form_field_item.dart';
import '../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../common/widgets/phone_number_field/phone_number_field.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/size_config.dart';
import '../../change_language/bloc/change_language_bloc.dart';
import '../../change_language/view/change_language_view.dart';
import '../../contact_us/bloc/contact_us_bloc.dart';
import '../../contact_us/view/contact_us_view.dart';
import '../../menu/view/widget/button_item_widget.dart';
import '../bloc/sign_in_bloc.dart';

class SignInView extends BaseStatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends BaseState<SignInView> {
  late SignInBloc _signInBloc;
  late ChangeLanguageBloc _changeLanguageBloc;
  late FirebaseTokenBloc _firebaseTokenBloc;

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _changeLanguageBloc = BlocProvider.of<ChangeLanguageBloc>(context);
    _firebaseTokenBloc = BlocProvider.of<FirebaseTokenBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.padding * 3,
            right: SizeConfig.padding * 3,
            bottom: SizeConfig.padding),
        child: Form(
          key: _signInBloc.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: SizeConfig.padding * 6),
              Center(
                child: AppImage(
                  path: AppAssets.coloredLogoPng,
                  width: SizeConfig.blockSizeHorizontal * 50,
                  height: SizeConfig.blockSizeHorizontal * 50,
                ),
              ),
              SizedBox(height: SizeConfig.padding * 5),
              PhoneNumberField(
                controller:
                    _signInBloc.alternatePhoneNumberTextEditingController,
                subject: _signInBloc.alternatePhoneNumberSubject,
                languageCode: AppConstants.selectedLanguage,
                onChanged: (number) {
                  _signInBloc.updateSelectedAlternatePhoneNumber(number);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textColor: Colors.black,
                boarderColor: AppColors.primaryColor,
                focusedBorderColor: AppColors.primaryColor,
                enabledBorderColor: AppColors.greyColor,
                fillColor: AppColors.whiteColor,
                boarderRadius: SizeConfig.btnHeight,
                disableLengthCheck: false,
                onCountryChanged: (country) {
                  // personalInformationBloc.clearSelectedPhoneNumber();
                  _signInBloc.updateSelectedAlternatePhoneNumber(PhoneNumber(
                      countryISOCode: country.dialCode,
                      countryCode: country.code,
                      number: _signInBloc.alternatePhoneNumberSubject
                              .valueOrNull?.number ??
                          ''));
                },
                isValidPhone: _signInBloc.isValidPhone,
              ),
              SizedBox(height: SizeConfig.padding * 1.5),
              AppTextFormFieldItem(
                title: AppLocalizations.of(context).password,
                formFieldItemType: AppFormFieldItemType.password,
                subject: _signInBloc.passwordSubject,
                obscureTextSubject: _signInBloc.obscureTextSubject,
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
                // submit: () => _signInBloc.formKey.currentState!.validate()
                //     ? _signInBloc.login(_firebaseTokenBloc)
                //     : null,
                validator: (value) => _signInBloc.validatePassword(value!),
                onTap: () {
                  _signInBloc.phoneNumberContainerBorderColorSubject.sink
                      .add(AppColors.greyColor);
                },
              ),
              SizedBox(height: SizeConfig.padding / 2),
              AppButton(
                title: AppLocalizations.of(context).forgotPassword,
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.textFontSize,
                    fontColor: AppColors.primaryColor),
                borderColor: AppColors.transparentColor,
                backgroundColor: AppColors.transparentColor,
                radius: SizeConfig.btnRadius,
                alignment: AppButtonAlign.center,
                onTap: () => Utilities.navigateAndPop(
                  BlocProvider<ForgotPasswordBloc>(
                    bloc: ForgotPasswordBloc(),
                    child: const ForgotPasswordView(),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.padding),
              AppButton(
                  title: AppLocalizations.of(context).login,
                  style: AppTextStyle.style(
                      fontFamily: Fonts.regular.name,
                      fontSize: SizeConfig.textFontSize,
                      fontColor: AppColors.whiteColor),
                  borderColor: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  radius: SizeConfig.blockSizeHorizontal * 2,
                  alignment: AppButtonAlign.center,
                  onTap: () => _signInBloc.formKey.currentState!.validate()
                      ? _signInBloc.login(_firebaseTokenBloc)
                      : null),
              SizedBox(height: SizeConfig.padding *2),
              Row(
                children: [
                  AppImage(
                    path: AppAssets.profile,
                    width: SizeConfig.iconSize,
                    height: SizeConfig.iconSize,
                    color: AppColors.fontColor(),
                  ),
                  SizedBox(width: SizeConfig.padding / 2),
                  AppText(label: AppLocalizations.of(context).haveNoAccount, style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor()),),
                  // AppText(label: AppLocalizations.of(context).to, style: AppTextStyle.style(
                  //     fontFamily: '',
                  //     fontSize: SizeConfig.titleFontSize,
                  //     fontColor: AppColors.fontColor()),),
                  // AppText(label: AppLocalizations.of(context).createAccount, style: AppTextStyle.style(
                  //     fontFamily: '',
                  //     fontSize: SizeConfig.titleFontSize,
                  //     fontColor: AppColors.fontColor()),),
                  AppButton(
                    title: AppLocalizations.of(context).contactUs.toUpperCase(),
                    style: AppTextStyle.style(
                        fontFamily: Fonts.bold.name,
                        fontSize: SizeConfig.titleFontSize,
                        fontColor: AppColors.primaryColor),
                    borderColor: AppColors.transparentColor,
                    backgroundColor: AppColors.transparentColor,
                    radius: SizeConfig.btnRadius,
                    alignment: AppButtonAlign.center,
                    onTap: () => Utilities.navigate(
                      BlocProvider(
                        bloc: ContactUsBloc(),
                        child: const ContactUsView(),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.padding*2),
              ButtonItemWidget(
                title: AppLocalizations.of(context).language,
                iconPath: AppAssets.language,
                onTap: () => Utilities.navigate(ChangeLanguageView(
                  changeLanguageBloc: _changeLanguageBloc,
                )),
                changeLanguageBloc: _changeLanguageBloc,
                margin: EdgeInsets.zero,
              ),
              SizedBox(height: SizeConfig.padding * 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> setOnWillPop() {
    // TODO: implement onWillPop
    return Future.value(true);
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
