import 'package:etammn/common/widgets/app_image.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../common/blocs/timer/timer_bloc.dart';
import '../../../common/widgets/app_back_icon.dart';
import '../../../common/widgets/app_button.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import '../../../utilities/utilities.dart';
import '../../forgot_password/bloc/forgot_password_bloc.dart';
import '../../forgot_password/view/forgot_password_view.dart';
import '../Bloc/verification_code_bloc.dart';

class VerificationCodeView extends BaseStatefulWidget {
  const VerificationCodeView({Key? key}) : super(key: key);

  @override
  _VerificationCodeViewState createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends BaseState<VerificationCodeView> {
  late VerificationCodeBloc verificationCodeBloc;
  late TimerBloc? _timerBloc;

  @override
  void initState() {
    super.initState();
    // verificationCodeBloc.errorController =
    //     StreamController<ErrorAnimationType>();
    verificationCodeBloc = BlocProvider.of<VerificationCodeBloc>(context);
    _timerBloc = BlocProvider.of<TimerBloc>(context);
    _timerBloc?.incrementTimer(59);
  }

  @override
  void dispose() {
    _timerBloc?.dispose();
    verificationCodeBloc.dispose();
    super.dispose();
  }

  @override
  Widget setBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.padding * 2),
            AppBackIcon(onTap: () => setOnWillPop()),
            SizedBox(height: SizeConfig.padding * 3),
            Center(
                child: AppImage(
              path: AppAssets.confirmed,
              width: SizeConfig.blockSizeHorizontal * 60,
              height: SizeConfig.blockSizeVertical * 30,
            )),
            SizedBox(height: SizeConfig.padding * 2),
            Center(
              child: AppText(
                label: AppLocalizations.of(context).codeSentToEmail,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: SizeConfig.padding * 2),
            Form(
                child: StreamBuilder(
                    stream: verificationCodeBloc.pinCodeHasErrorSubject.stream,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 4) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.circle,
                                borderRadius: BorderRadius.circular(15),
                                borderWidth: 1,
                                fieldHeight: 60,
                                fieldWidth: 60,
                                activeColor: Colors.grey.withOpacity(0.5),
                                activeFillColor:
                                    snapshot.hasData && snapshot.data == true
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                inactiveColor: Colors.grey.withOpacity(0.5),
                                selectedColor: AppColors.primaryColor,
                                selectedFillColor: Colors.white,
                                inactiveFillColor: Colors.white),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            // textStyle: AppFontStyle.latoBold(
                            //     SizeConfig.textFontSize, AppColors.BLACK_COLOR),
                            backgroundColor: Colors.white,
                            enableActiveFill: true,
                            errorAnimationController:
                                verificationCodeBloc.errorController,
                            controller: verificationCodeBloc.pinCodeController,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              print('pin code : $v');
                              verificationCodeBloc.verificationCodeSubject.sink
                                  .add(v);
                            },
                            onChanged: (value) {
                              verificationCodeBloc.pinCodeHasErrorSubject.sink
                                  .add(false);
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ],
                      );
                    })),
            SizedBox(height: SizeConfig.padding * 2),
            AppButton(
                title: AppLocalizations.of(context).confirm,
                style: AppTextStyle.style(
                    fontFamily: Fonts.regular.name,
                    fontSize: SizeConfig.titleFontSize,
                    fontColor: AppColors.whiteColor),
                borderColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor,
                width: SizeConfig.blockSizeHorizontal * 100,
                radius: SizeConfig.blockSizeHorizontal * 2,
                alignment: AppButtonAlign.center,
                onTap: () => verificationCodeBloc.checkCode()),
            SizedBox(height: SizeConfig.padding * 2),
            Center(
              child: AppText(
                label: AppLocalizations.of(context).didNotGetCode,
                style: AppTextStyle.style(
                    fontFamily: '',
                    fontSize: SizeConfig.textFontSize,
                    fontColor: AppColors.greyColor),
              ),
            ),
            SizedBox(height: SizeConfig.padding * 2),
            Center(child: btnRequestNewCode())
          ],
        ),
      ),
    );
  }

  Widget btnRequestNewCode() {
    return StreamBuilder(
        stream: _timerBloc?.timerStoppedSubject.stream,
        builder: (context, timerSnapshot) {
          return Container(
            width: SizeConfig.blockSizeHorizontal * 50,
            height: SizeConfig.blockSizeVertical * 7,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  foregroundColor: timerSnapshot.hasData && timerSnapshot.data == true
                      ? AppColors.primaryColor
                      : AppColors.lightGreyColor, side: BorderSide(
                    color: timerSnapshot.hasData && timerSnapshot.data == true
                        ? AppColors.primaryColor
                        : AppColors.lightGreyColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor:
                      timerSnapshot.hasData && timerSnapshot.data == true
                          ? AppColors.primaryColor
                          : AppColors.lightGreyColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    label: AppLocalizations.of(context).sendItAgain,
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.smallTextFontSize,
                      fontColor:
                          timerSnapshot.hasData && timerSnapshot.data == true
                              ? AppColors.whiteColor
                              : AppColors.fontColor().withOpacity(0.5),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: StreamBuilder<int>(
                          stream: _timerBloc?.timerStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AppText(
                                label: Utilities.formattedTime(
                                    snapshot.data ?? 59),
                                style: TextStyle(
                                  color: timerSnapshot.hasData &&
                                          timerSnapshot.data == true
                                      ? AppColors.whiteColor
                                      : AppColors.fontColor().withOpacity(0.5),
                                  fontSize: 12,
                                  fontFamily: 'LatoRegular',
                                  letterSpacing: 0.24,
                                ),
                              );
                            } else {
                              return AppText(
                                label: '01:59',
                                style: TextStyle(
                                  color: AppColors.fontColor().withOpacity(0.5),
                                  fontSize: 14,
                                  letterSpacing: 0.24,
                                ),
                              );
                            }
                          })),
                ],
              ),
              onPressed: timerSnapshot.hasData && timerSnapshot.data == false
                  ? null
                  : () {
                      _timerBloc?.incrementTimer(59);
                    },
            ),
          );
        });
  }

  @override
  Future<bool> setOnWillPop() {
    // TODO: implement onWillPop
    return Utilities.navigateAndPop(BlocProvider<ForgotPasswordBloc>(
        bloc: ForgotPasswordBloc(), child: const ForgotPasswordView()));
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
