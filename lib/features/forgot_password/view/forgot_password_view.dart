import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/blocs/countries/countries_bloc.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/widgets/app_back_icon.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_image.dart';
import '../../../common/widgets/app_text_form_field_item.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/size_config.dart';
import '../../../utilities/utilities.dart';
import '../../change_language/bloc/change_language_bloc.dart';
import '../../sign_in/bloc/sign_in_bloc.dart';
import '../../sign_in/view/sign_in_view.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordView extends BaseStatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends BaseState<ForgotPasswordView> {
  ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding * 3),
        child: Form(
          key: _forgotPasswordBloc.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              AppBackIcon(onTap:()=> setOnWillPop()),

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
                  title: AppLocalizations.of(context).email,
                  formFieldItemType: AppFormFieldItemType.email,
                  subject: _forgotPasswordBloc.emailSubject,
                  textInputType: TextInputType.emailAddress,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  prefixIcon:  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: SizeConfig.padding * 1.5),
                    child: AppImage(path:AppAssets.email,height: SizeConfig.iconSize,width: SizeConfig.iconSize,),
                  ),
                  submit: () =>
                      _forgotPasswordBloc.formKey.currentState!.validate()
                          ? _forgotPasswordBloc.forgotPassword()
                          : null,
                  validator: (value) =>
                      _forgotPasswordBloc.validateEmail(value!)),
              SizedBox(height: SizeConfig.padding * 3),
              AppButton(
                  title: AppLocalizations.of(context).send,
                  style: AppTextStyle.style(
                      fontFamily: Fonts.regular.name,
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.whiteColor),
                  borderColor: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  radius: SizeConfig.blockSizeHorizontal * 2,
                  alignment: AppButtonAlign.center,
                  onTap: () =>
                      _forgotPasswordBloc.formKey.currentState!.validate()
                          ? _forgotPasswordBloc.forgotPassword()
                          : null),
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
