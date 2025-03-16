import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/constants/colors.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:etammn/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';

class EventsTabsWidget extends StatelessWidget {
 final SystemDetailsBloc bloc;
  const EventsTabsWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: bloc.selectedEventsSubject,
      builder: (context, snapshot) {
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
              border: Border(bottom:
                  BorderSide(color: snapshot.data==bloc.activeEvents?AppColors.primaryColor:AppColors.greyColor))),
              child: AppButton(
            title: AppLocalizations.of(context).activeEvents,
            style: AppTextStyle.style(
                fontFamily: '',
                fontSize: SizeConfig.textFontSize,
                fontColor: snapshot.data==bloc.activeEvents?AppColors.primaryColor:AppColors.greyColor),
            onTap: null,
            // onTap: () =>bloc.changeSelectedTab(bloc.activeEvents),
            backgroundColor: AppColors.transparentColor,
            borderColor: AppColors.transparentColor,
              ),
            ),
            // Expanded(
            //     child: Container(
            //       decoration: BoxDecoration(
            //           border: Border(bottom:
            //           BorderSide(color: snapshot.data==bloc.eventsLogs?AppColors.primaryColor:AppColors.greyColor))),
            //       child: AppButton(
            //         title: AppLocalizations.of(context).eventsLogs,
            //         style: AppTextStyle.style(
            //             fontFamily: '',
            //             fontSize: SizeConfig.textFontSize,
            //             fontColor: snapshot.data==bloc.eventsLogs?AppColors.primaryColor:AppColors.greyColor),
            //         onTap: () =>bloc.changeSelectedTab(bloc.eventsLogs),
            //         backgroundColor: AppColors.transparentColor,
            //         borderColor: AppColors.transparentColor,
            //       ),
            //     )),
          ],
        );
      }
    );
  }
}
