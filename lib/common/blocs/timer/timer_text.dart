import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/size_config.dart';
import '../../../utilities/utilities.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import 'timer_bloc.dart';

class TimerText extends StatelessWidget {
  final TimerBloc timerBloc;

  const TimerText({Key? key, required this.timerBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          label: 'AppStrings.resendCode',
          style: AppTextStyle.style(
              fontFamily: Fonts.regular.name,
              fontSize: SizeConfig.textFontSize,
              fontColor: AppColors.greyColor),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: StreamBuilder<int>(
                stream: timerBloc.timerStream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData) {
                    return AppText(
                      label: Utilities.formattedTime(snapshot.data ?? 120),
                      style: AppTextStyle.style(
                          fontFamily: Fonts.regular.name,
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.greyColor),
                    );
                  } else {
                    return AppText(
                      label: '01:59',
                      style: AppTextStyle.style(
                          fontFamily: Fonts.regular.name,
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.greyColor),
                    );
                  }
                })),
        StreamBuilder<bool>(
            stream: timerBloc.timerStoppedSubject.stream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              log(snapshot.data.toString());
              if (snapshot.data == null || snapshot.data == false) {
                return const SizedBox();
              } else {
                return AppButton(
                    title: 'AppStrings.resendCode',
                    style: AppTextStyle.style(
                        fontFamily: Fonts.bold.name,
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.greyColor),
                    borderColor: AppColors.transparentColor,
                    backgroundColor: AppColors.transparentColor,
                    height: SizeConfig.btnHeight / 4 * 3,
                    onTap: () => timerBloc.incrementTimer(30));
              }
            })
      ],
    );
  }
}
